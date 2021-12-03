// use itertools::Itertools;
use std::collections::HashMap;
use std::convert::TryInto;

fn hash_map_max_by_val<K, V>(map: &HashMap<K, V>) -> Option<&K>
where
    V: Ord,
{
    map.iter().max_by(|a, b| a.1.cmp(&b.1)).map(|(k, _v)| k)
}

fn hash_map_min_by_val<K, V>(map: &HashMap<K, V>) -> Option<&K>
where
    V: Ord,
{
    map.iter().min_by(|a, b| a.1.cmp(&b.1)).map(|(k, _v)| k)
}

pub fn first() {
    let filename = "data/day03.txt";

    let lines = super::helpers::read_lines(filename);

    let mut vectors: Vec<HashMap<u32, u32>> = Vec::new();

    for l in lines {
        for (i, c) in l.unwrap().chars().enumerate() {
            if vectors.len() < i + 1 {
                vectors.push(HashMap::new());
            }

            let entry = vectors[i].entry(c.to_digit(10).unwrap()).or_insert(0);
            *entry += 1;
        }
    }

    let mut gamma_rate: u32 = 0;
    let mut epsilon_rate: u32 = 0;
    for (i, digit_counter) in vectors.iter().rev().enumerate() {
        let gamma_digit = hash_map_max_by_val(digit_counter).unwrap();
        let epsilon_digit = hash_map_min_by_val(digit_counter).unwrap();

        let factor = (2 as u32).pow(i.try_into().unwrap());

        gamma_rate += factor * gamma_digit;
        epsilon_rate += factor * epsilon_digit;
    }

    println!("Day 03 part 1: {}", gamma_rate * epsilon_rate);
}

fn find_most_common(vectors: &Vec<Vec<u32>>, pos: usize) -> u32 {
    let mut counter: HashMap<u32, i32> = HashMap::new();

    for vec in vectors {
        let entry = counter.entry(vec[pos]).or_insert(0);
        *entry += 1;
    }

    if counter.len() == 2 && counter[&0] == counter[&1] {
        return 1;
    }

    *hash_map_max_by_val(&counter).unwrap()
}

fn find_least_common(vectors: &Vec<Vec<u32>>, pos: usize) -> u32 {
    let mut counter: HashMap<u32, i32> = HashMap::new();

    for vec in vectors {
        let entry = counter.entry(vec[pos]).or_insert(0);
        *entry += 1;
    }

    if counter.len() == 2 && counter[&0] == counter[&1] {
        return 0;
    }
    *hash_map_min_by_val(&counter).unwrap()
}

fn to_number(vec: &Vec<u32>) -> u32 {
    let mut acc = 0;
    for (i, v) in vec.iter().rev().enumerate() {
        acc += v * 2_u32.pow(i.try_into().unwrap());
    }
    acc
}

pub fn second() {
    let filename = "data/day03.txt";

    let lines = super::helpers::read_lines(filename);

    let mut oxygen_candidates: Vec<Vec<u32>> = lines
        .map(|l| {
            let mut vec = Vec::new();
            for c in l.unwrap().chars() {
                if let Some(digit) = c.to_digit(10) {
                    vec.push(digit);
                }
            }
            vec
        })
        .collect();

    let mut co2_candidates = oxygen_candidates.clone();

    let mut idx = 0;
    while oxygen_candidates.len() > 1 {
        let most_common = find_most_common(&oxygen_candidates, idx);
        oxygen_candidates = oxygen_candidates
            .into_iter()
            .filter(|v| v[idx] == most_common)
            .collect();
        idx += 1;
    }

    idx = 0;
    while co2_candidates.len() > 1 {
        let least_common = find_least_common(&co2_candidates, idx);
        co2_candidates = co2_candidates
            .into_iter()
            .filter(|v| v[idx] == least_common)
            .collect();
        idx += 1;
    }

    let oxygen_number = to_number(&oxygen_candidates[0]);
    let co2_number = to_number(&co2_candidates[0]);

    println!("Day 03 part 2: {}", oxygen_number * co2_number);
}
