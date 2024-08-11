module main

pub struct Lexer {
	source []u8 @[required]
mut:
	i           usize
	token_start usize
	token_end   usize
}

pub fn (mut l Lexer) next() ?Token {
	l.skip_whitespace()

	if l.i >= l.source.len {
		return none
	}

	ch := l.source[l.i]

	if ch == '"'.bytes()[0] {
		return l.parse_string()
	}
	if ch.is_letter() {
		return l.parse_ident()
	} else if ch.is_digit() {
		return l.parse_number()
	}

	l.token_start = l.i
	l.i += 1
	l.token_end = l.i
	return Token.symbol
}

fn (mut l Lexer) parse_ident() Token {
	l.token_start = l.i

	for l.i < l.source.len && (l.source[l.i].is_alnum() || l.source[l.i] == '_'.bytes()[0]) {
		l.i += 1
	}

	l.token_end = l.i
	return Token.ident
}

fn (mut l Lexer) parse_number() Token {
	l.token_start = l.i

	for l.i < l.source.len && (l.source[l.i].is_digit() || l.source[l.i] == '.'.bytes()[0]) {
		l.i += 1
	}

	l.token_end = l.i
	return Token.number
}

fn (mut l Lexer) parse_string() Token {
	l.i += 1
	l.token_start = l.i

	for l.i < l.source.len && l.source[l.i] != '"'.bytes()[0] {
		l.i += 1
	}

	l.token_end = l.i
	l.i += 1
	return Token.str
}

fn (mut l Lexer) skip_whitespace() {
	for l.i < l.source.len && l.source[l.i].is_space() {
		l.i += 1
	}
}

pub fn (l Lexer) slice() []u8 {
	return l.source[l.token_start..l.token_end]
}
