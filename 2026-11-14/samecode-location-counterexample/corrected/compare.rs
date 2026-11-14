mod samecode;
fn main() {
    let args: Vec<_> = std::env::args().collect();
    println!("{:?}", samecode::compare(
        std::path::Path::new(&args[1]), std::path::Path::new(&args[2]), &[]));
}
