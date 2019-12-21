use std::fs;
use std::vec::Vec;

fn do_op(memory: &mut Vec<i32>, index: &mut usize) {
    let lhs = memory[*index + 1] as usize;
    let rhs = memory[*index + 2] as usize;
    let target = memory[*index + 3] as usize;

    memory[target] = match memory[*index] {
        1 => memory[lhs] + memory[rhs],
        2 => memory[lhs] * memory[rhs],
        _ => panic!("Invalid operation"),
    };
    *index = *index + 4;
}

pub fn first() {
    let filename = "day02-01.txt";

    let contents = fs::read_to_string(filename).unwrap();
    let mut memory: Vec<i32> = contents
        .trim()
        .split(",")
        .map(|i| i.parse::<i32>().unwrap())
        .collect();

    let mut index = 0;
    loop {
        match memory[index] {
            1|2 => do_op(&mut memory, &mut index),
            99 => break,
            _ => panic!("Not reachable"),
        }
    }

    println!("Day 2 - 1: {}", memory[0]);
}
