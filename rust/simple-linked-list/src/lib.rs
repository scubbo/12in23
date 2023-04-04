use std::iter::FromIterator;

pub struct SimpleLinkedList<T> {
    head: Option<Node<T>>
}

struct Node<T> {
    val: T,
    next: Option<Box<Node<T>>>
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    pub fn is_empty(&self) -> bool {
        self.head.is_none()
    }

    pub fn len(&self) -> usize {
        fn inner_len<Q>(h: &Node<Q>) -> usize {
            // &(*h) feels like a no-op? But it's what the
            // compiler suggested...?
            match &(*h).next {
                Some(n) => 1 + inner_len(&*n),
                None => 1
            }
        }
        match &self.head {
            Some(b) => inner_len(b),
            None => 0
        }
    }

    pub fn push(&mut self, _element: T) {

        self.head = Some(if self.is_empty() {
            Node {
                val: _element,
                next: None
            }
        } else {
            Node {
                val: _element,
                next: Some(Box::new(self.head.take().unwrap()))
            }
        })

        // Initially tried:
        //
        // let next_value = match self.peek() {
        //     Some(v) => Some(Box::new(self.head.unwrap())),
        //     None => None
        // };
        // self.head = Some(Node{val: _element, next: next_value});
        //
        // but `self.head` gave an error "Cannot move out of `self.head`
        // which is behind a mutable reference". What does that mean?
        //
    }

    pub fn pop(&mut self) -> Option<T> {

        match self.head.take() {
            None => None,
            Some(mut node) => {
                match node.next.take() {
                    Some(n) => {
                        self.head = Some(*n);
                    },
                    None => {
                        self.head = None
                    }
                }
                Some(node.val)
            }
        }

        // As above - I initially tried:
        //
        // match self.head {
        //     Some(n) => {
        //         let val = n.val;
        //         self.head = Some(*self.head.unwrap().next)
        //     }
        //     None => None
        // }
        //
        // But `match self.head` gave a "cannot move" error.
        // I don't understand the problem - I'm not trying to move it,
        // I'm just trying to read it! Since `&mut self` is a reference,
        // there shouldn't be any ownership issue?
        //
        // It seems like `.take()` is doing exactly what I want to do - read the
        // value without "moving" it - but that's not what I understand from its
        // documentation, which states exactly the opposite - that it
        // "Takes the value out of the option, leaving a None in its place.".
        // That sounds like moving to me?


    }

    pub fn peek(&self) -> Option<&T> {
        // I don't understand why `.as_ref()` is necessary here -
        // `&self` is _already_ a ref?
        self.head.as_ref().map(|head| &(head.val))

        // Without `as_ref()`, the below gave an error while compiling
        // "(expected `&T`, found type parameter `T`)", but no
        // red-underline while writing. Is this expected?
        //
        // self.head.map(|node| node.val).as_ref()
        //
        // And, again - `self.head` gave an error "`self.head` moved due to this
        // method call".
    }

    #[must_use]
    pub fn rev(mut self) -> SimpleLinkedList<T> {
        // Extremely confused here - I looked at an answer to understand
        // what my solution was doing wrong, and their solution had changed the signature
        // from `self` to `mut self`. That seems like cheating?
        let mut new_list = SimpleLinkedList::new();
        while let Some(x) = self.pop() {
            new_list.push(x)
        }
        new_list


        // Below is my attempt, which looks _mostly_ the same but:
        // * Creates a variable for `cur_head`
        // * Extracts the value to push with `cur_head.unwrap().val`, to avoid
        //    mutating the original list - which I would have thought was desirable?
        //
        // but the errors given say
        // * move occurs because `cur_head` has type `Option<Node<T>>`,
        //     which does not implement the `Copy` trait.
        // * `cur_head` moved due to this method call" (`cur_head.unwrap()`).
        // * "value used here after move" (`cur_head = Some(*(cur_head...`)
        //
        // I seem to just not understand what "moving" is? I could swear this hasn't
        // been covered in any of the concepts in the Rust track.
        //
        // https://doc.rust-lang.org/rust-by-example/scope/move.html suggests that
        // "When doing assignments (let x = y) or passing function arguments by value (foo(x)), the
        // ownership of the resources is transferred. In Rust-speak, this is known as a move."
        //
        // I don't see how that applies here, though? `cur_head.unwrap` is neither doing an assignment
        // nor passing a function argument by value - in fact, there are no function arguments to
        // `unwrap`. If the implicit `self` argument counts, then that seems to imply you can never
        // call any methods on any variables without generating a move. If that's the case...how
        // would you ever get anything done!?
        //
        //
        // let mut new_list = SimpleLinkedList::new();
        // let mut cur_head = self.head;
        // while cur_head.is_some() {
        //     new_list.push(cur_head.unwrap().val);
        //     // As in `pop` above, this feels really awkward.
        //     cur_head = Some(*(cur_head.unwrap().next.unwrap()));
        // }
        // new_list
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(_iter: I) -> Self {
        let mut l = SimpleLinkedList::new();
        for item in _iter {
            l.push(item);
        }
        l
    }
}


impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut _linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut vec = Vec::with_capacity(_linked_list.len());
        if _linked_list.is_empty() {
            return vec;
        }

        let mut revd = _linked_list.rev();
        for _ in 0..revd.len() {
            vec.push(revd.pop().unwrap())
        }
        vec

        // This is plain awful.
        // But my initial attempt:
        //
        //
        // for i in 0.._linked_list.len() {
        //     vec[i] = _linked_list.pop().unwrap()
        // }
        // vec
        //
        // gave an error "the len is 0 but the index is 0" -
        // despite the fact that I'd allocated the vector with the corrrect size.
        //
        // I am probably going to give up on Exercism exercises and just read through
        // https://doc.rust-lang.org/book/, since I've clearly missed some really
        // fundamental concepts. That said, I'd really appreciate any pointers you can
        // give on what I appear to be missing. This was really discouraging and I'd hate
        // to come away with a negative view of a language that so many people love so much.
    }
}
