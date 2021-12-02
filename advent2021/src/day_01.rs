pub fn first() {
    let filename = "data/day01.txt";

    let lines = super::helpers::read_lines(filename);
    let numbers = lines.map(|l| l.unwrap().parse::<i32>().unwrap());
    let (acc, _) = numbers.fold((0, i32::MAX), |(acc, previous), x| {
        (acc + ((previous < x) as i32), x)
    });

    println!("Day 01 part 1: {}", acc);
}

pub fn second() {
    let filename = "data/day01.txt";

    let lines = super::helpers::read_lines(filename);
    let numbers: Vec<_> = lines.map(|l| l.unwrap().parse::<i32>().unwrap()).collect();
    let windows_sums = numbers.windows(3).map(|w| w.iter().sum());
    let (acc, _) = windows_sums.fold((0, i32::MAX), |(acc, previous), x| {
        (acc + ((previous < x) as i32), x)
    });

    println!("Day 01 part 2: {}", acc);
}
