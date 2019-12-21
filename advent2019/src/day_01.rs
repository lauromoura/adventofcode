pub fn first() {
    let filename = "day01-01.txt";

    let fuel_for_modules: i32 = super::helpers::read_lines(filename)
        .map(|s| s.unwrap().parse::<i32>().unwrap())
        .map(|i| weigth(i))
        .sum();
    println!("Day 1 - 1: {}", fuel_for_modules);
}

pub fn second() {
    let filename = "day01-01.txt";

    let fuel_for_modules: i32 = super::helpers::read_lines(filename)
        .map(|s| s.unwrap().parse::<i32>().unwrap())
        .map(|i| total_fuel(i))
        .sum();
    println!("Day 1 - 2: {}", fuel_for_modules);
}

fn total_fuel(mass: i32) -> i32 {
    let initial_fuel = weigth(mass);

    let mut total = initial_fuel;
    let mut current_fuel = total;

    while current_fuel > 0 {
        let new_fuel = weigth(current_fuel);
        if new_fuel > 0 {
            total += new_fuel
        }
        current_fuel = new_fuel;
    }
    total
}

fn weigth(mass: i32) -> i32 {
    mass / 3 - 2
}
