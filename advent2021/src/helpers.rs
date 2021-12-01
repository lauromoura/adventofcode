use std::fs::File;
use std::io::{BufRead, BufReader};

pub fn read_lines(filename: &str) -> std::io::Lines<std::io::BufReader<std::fs::File>> {
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);
    reader.lines()
}
