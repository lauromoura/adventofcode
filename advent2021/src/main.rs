mod day_01;
mod day_02;
mod day_03;
mod day_04;
mod day_05;
mod helpers;

use std::env;

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    let all = args.is_empty();

    if all || args.contains(&"-1".to_owned()) {
        day_01::first();
        day_01::second();
    }
    if all || args.contains(&"-2".to_owned()) {
        day_02::first();
        day_02::second();
    }
    if all || args.contains(&"-3".to_owned()) {
        day_03::first();
        day_03::second();
    }
    if all || args.contains(&"-4".to_owned()) {
        day_04::first();
        day_04::second();
    }
    if all || args.contains(&"-5".to_owned()) {
        day_05::first();
        day_05::second();
    }
}
