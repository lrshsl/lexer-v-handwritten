module main

const input = ('hey
what
69 < 42
move(x,y);


mov x      <- y

      veryLongWeird___function_name89_8thatCouldBE_POSSIBLE_4();
').bytes()

fn main() {
	mut lexer := Lexer{
		source: input
	}
	for {
		tok := lexer.next() or { break }
		println('${tok:-6} | ${lexer.slice().bytestr()}')
	}
}
