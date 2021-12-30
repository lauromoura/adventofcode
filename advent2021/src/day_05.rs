use std::collections::HashMap;
use std::mem;

pub fn first() {
    let filename = "data/day05.txt";
    let lines = super::helpers::read_lines(filename);

    let mut counter: HashMap<(i32, i32), i32> = HashMap::new();

    for line in lines {
        let string = line.unwrap();
        let (p0, p1) = string.split_once(" -> ").unwrap();
        let (x0_s, y0_s) = p0.split_once(",").unwrap();
        let (x1_s, y1_s) = p1.split_once(",").unwrap();

        // Uuugh
        let mut x0 = x0_s.parse::<i32>().unwrap();
        let mut y0 = y0_s.parse::<i32>().unwrap();
        let mut x1 = x1_s.parse::<i32>().unwrap();
        let mut y1 = y1_s.parse::<i32>().unwrap();

        if x0 == x1 {
            if y0 > y1 {
                mem::swap(&mut y0, &mut y1);
            }
            for y in y0..=y1 {
                let entry = counter.entry((x0, y)).or_insert(0);
                *entry += 1;
            }
        } else if y0 == y1 {
            if x0 > x1 {
                mem::swap(&mut x0, &mut x1);
            }
            for x in x0..=x1 {
                let entry = counter.entry((x, y0)).or_insert(0);
                *entry += 1;
            }
        }
    }

    let count = counter.values().filter(|v| *v > &1).count();

    println!("Day 05 part 1: {}", count);
}

pub fn second() {
    let filename = "data/day05.txt";
    let lines = super::helpers::read_lines(filename);

    let mut counter: HashMap<(i32, i32), i32> = HashMap::new();

    for line in lines {
        let string = line.unwrap();
        let (p0, p1) = string.split_once(" -> ").unwrap();
        let (x0_s, y0_s) = p0.split_once(",").unwrap();
        let (x1_s, y1_s) = p1.split_once(",").unwrap();

        // Uuugh
        let mut x0 = x0_s.parse::<i32>().unwrap();
        let mut y0 = y0_s.parse::<i32>().unwrap();
        let mut x1 = x1_s.parse::<i32>().unwrap();
        let mut y1 = y1_s.parse::<i32>().unwrap();

        if x0 == x1 {
            if y0 > y1 {
                mem::swap(&mut y0, &mut y1);
            }
            for y in y0..=y1 {
                let entry = counter.entry((x0, y)).or_insert(0);
                *entry += 1;
            }
        } else if y0 == y1 {
            if x0 > x1 {
                mem::swap(&mut x0, &mut x1);
            }
            for x in x0..=x1 {
                let entry = counter.entry((x, y0)).or_insert(0);
                *entry += 1;
            }
        } else {
            let mut x = x0;
            let mut y = y0;
            let x_dir = if x0 < x1 { 1 } else { -1 };
            let y_dir = if y0 < y1 { 1 } else { -1 };

            while x != (x1 + x_dir) && y != (y1 + y_dir) {
                let entry = counter.entry((x, y)).or_insert(0);
                *entry += 1;
                x += x_dir;
                y += y_dir;
            }
        }
    }

    let count = counter.values().filter(|v| *v > &1).count();

    println!("Day 05 part 2: {}", count);
}
