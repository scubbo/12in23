pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {
        if self.health != 0 {
            return None
        }

        if self.level < 10 {
            return Some(Player{
                health: 100,
                level: self.level,
                mana: None
            })
        } else {
            return Some(Player{
                health: 100,
                level: self.level,
                mana: Some(100)
            })
        }

    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        // Is there really no `.get()` on an Option?
        // If not, how would you implement this with guard clauses, avoiding
        // the nesting that `match` requires?

        // Also the fact that you can declare scopes from a match hasn't been
        // taught, either.
        // This track is really missing some content!

        match self.mana {
            Some(mana_val) => {
                if mana_cost > mana_val {
                    0
                } else {
                    self.mana = Some(mana_val - mana_cost);
                    mana_cost * 2
                }
            },
            None => {
                self.reduce_health(mana_cost);
                0
            }
        }
    }

    fn reduce_health(&mut self, amount: u32) {
        if amount > self.health {
            self.health = 0
        } else {
            self.health = self.health - amount
        }
    }
}
