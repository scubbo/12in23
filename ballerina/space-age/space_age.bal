int SECONDS_IN_EARTH_YEAR = 31557600;

# Returns the age on another planet or error if it is not a planet.
#
# + planet - planet name as a string
# + seconds - person's age measured in seconds
# + return - person's age in years of that planet, or error if unknown planet.
function age(string planet, int seconds) returns float|error {
    float earth_years = <float>seconds / SECONDS_IN_EARTH_YEAR;

    float local_age = check inner_age(planet, earth_years);
    // Tests actually want responses rounded to 2 s.f.
    return local_age.round(2);
}

function inner_age(string planet, float earth_years) returns float|error {
    match planet {
        "Mercury" => {
            return earth_years / 0.2408467;
        }
        "Venus" => {
            return earth_years / 0.61519726;
        }
        "Earth" => {
            return earth_years;
        }
        "Mars" => {
            return earth_years / 1.8808158;
        }
        "Jupiter" => {
            return earth_years / 11.862615;
        }
        "Saturn" => {
            return earth_years / 29.447498;
        }
        "Uranus" => {
            return earth_years / 84.016846;
        }
        "Neptune" => {
            return earth_years / 164.79132;
        }
        _ => {
            return error("not a planet");
        }
    }
}
