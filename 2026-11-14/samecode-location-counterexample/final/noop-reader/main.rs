mod samecode;
fn main() {
    let a: Vec<_> = std::env::args().collect();
    let masks = [a[3].as_str(), a[4].as_str(), &a[3][..12], &a[4][..12]];
    println!("{:?}", samecode::compare(std::path::Path::new(&a[1]), std::path::Path::new(&a[2]), &masks));
}
