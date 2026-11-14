mod samecode;
fn main() {
    let a: Vec<_> = std::env::args().collect();
    println!("{:?}", samecode::compare(std::path::Path::new(&a[1]), std::path::Path::new(&a[2]), &[]));
}
