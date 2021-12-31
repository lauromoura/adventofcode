fn iterate(population: Vec<i32>) -> Vec<i32> {
    let mut new_cells: Vec<i32> = Vec::new();
    let mut new_population: Vec<i32> = Vec::new();

    for cell in population {
        if cell == 0 {
            new_cells.push(8);
            new_population.push(6);
        } else {
            new_population.push(cell - 1);
        }
    }

    new_population.append(&mut new_cells);

    return new_population;
}

pub fn first() {
    let filename = "data/day06.txt";

    let mut lines = super::helpers::read_lines(filename);

    let mut population: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .split(",")
        .map(|l| l.parse::<i32>().unwrap())
        .collect();

    // Generate initial seeds
    // Initial max: 5
    // So, generate a list with 85 generations
    for _ in 1..=80 {
        population = iterate(population);
    }

    println!("Day 06 part 1: {}", population.len());
}

fn iterate_cycle(days: &mut Vec<usize>) {
    let new_cells = days[0];

    for i in 1..=8 {
        days[i - 1] = days[i];
    }

    days[8] = new_cells;
    days[6] += new_cells;
}

pub fn second() {
    let filename = "data/day06.txt";

    let mut lines = super::helpers::read_lines(filename);

    let population: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split(",")
        .map(|l| l.parse::<usize>().unwrap())
        .collect();

    let mut days = vec![0, 0, 0, 0, 0, 0, 0, 0, 0];

    for age in population {
        days[age] += 1;
    }

    for _ in 1..=256 {
        iterate_cycle(&mut days);
    }

    println!("Day 06 part 2: {}", days.iter().sum::<usize>());
}
