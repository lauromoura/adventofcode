pub fn first() {
    let filename = "data/day07.txt";

    let mut lines = super::helpers::read_lines(filename);

    let mut positions: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .split(",")
        .map(|l| l.parse::<i32>().unwrap())
        .collect();

    positions.sort();

    let mid = positions.len() / 2;

    let median = positions[mid];
    let amount: i32 = positions.iter().map(|p| (p - median).abs()).sum();
    println!("Day 07 part 1: {}", amount);
}

pub fn second() {
    let filename = "data/day07.txt";

    let mut lines = super::helpers::read_lines(filename);

    let mut positions: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .split(",")
        .map(|l| l.parse::<i32>().unwrap())
        .collect();

    positions.sort();

    let mut min: Option<i32> = None;
    // Greeedy
    for i in 0..=*positions.last().unwrap() {
        let amount: i32 = positions
            .iter()
            .map(|p| {
                let distance = (p - i).abs();
                distance * (distance + 1) / 2
            })
            .sum();

        min = match min {
            None => Some(amount),
            Some(v) => Some(if v < amount { v } else { amount }),
        };
    }
    println!("Day 07 part 1: {}", min.unwrap());
}
