mod samecode;
fn main() {
    let args: Vec<_> = std::env::args().collect();
    for locations in [false, true] {
        println!("locations={locations}: {:?}", samecode::compare(
            std::path::Path::new(&args[1]), std::path::Path::new(&args[2]), &[], locations));
    }
}
