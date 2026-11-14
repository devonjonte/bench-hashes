use std::mem::MaybeUninit;

struct Ring<X> {
    buf: Box<[MaybeUninit<X>]>,
    head: usize,
    len: usize,
}

impl<X> Ring<X> {
    fn new(cap: usize) -> Self {
        Ring { buf: (0..cap).map(|_| MaybeUninit::uninit()).collect(), head: 0, len: 0 }
    }

    #[inline(always)]
    fn len(&self) -> usize {
        self.len
    }

    #[inline(always)]
    fn is_empty(&self) -> bool {
        self.len == 0
    }

    #[inline(always)]
    fn front(&self) -> Option<&X> {
        if self.len == 0 { None } else { Some(unsafe { self.buf[self.head].assume_init_ref() }) }
    }

    #[inline(always)]
    fn push_back(&mut self, item: X) {
        let cap = self.buf.len();
        debug_assert!(self.len < cap, "Ring capacity exceeded");
        let idx = (self.head + self.len) % cap;
        self.buf[idx].write(item);
        self.len += 1;
    }

    #[inline(always)]
    fn pop_front(&mut self) -> Option<X> {
        if self.len == 0 {
            return None;
        }
        let item = unsafe { self.buf[self.head].assume_init_read() };
        self.head = (self.head + 1) % self.buf.len();
        self.len -= 1;
        Some(item)
    }
}

impl<X> Drop for Ring<X> {
    fn drop(&mut self) {
        while self.pop_front().is_some() {}
    }
}


#[cfg(test)]
mod tests {
    use super::*;
    use std::mem::ManuallyDrop;

    // A zero-sized token owns no allocation. Its cleanup stays observable.
    struct Token;
    impl Drop for Token {
        fn drop(&mut self) { std::thread::yield_now(); }
    }

    #[test]
    fn ordinary_cleanup() {
        let mut ring = Ring::new(1);
        ring.push_back(Token);
        assert!(ring.pop_front().is_some());
        assert_eq!(ring.len(), 0, "popping the sole token empties the ring");
    }

    #[test]
    fn protected_cleanup() {
        let mut ring = ManuallyDrop::new(Ring::new(1));
        ring.push_back(Token);
        assert!(ring.pop_front().is_some());
        assert_eq!(ring.len(), 0, "popping the sole token empties the ring");
        // The successful path still checks ordinary destruction, exactly once.
        unsafe { ManuallyDrop::drop(&mut ring); }
    }
}
