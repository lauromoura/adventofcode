Nonterminals expression elem.
Terminals '->' number identifier unaryop binaryop shiftop.
Rootsymbol expression.

elem -> number : extract_value('$1').
elem -> identifier : extract_value('$1').

expression -> elem '->' identifier : {extract_value('$3'), {extract_token('$2'), '$1'}}.
expression -> unaryop elem '->' identifier : {extract_value('$4'), {extract_value('$1'), '$2'}}.
expression -> elem binaryop elem '->' identifier : {extract_value('$5'), {extract_value('$2'), '$1', '$3'}}.
expression -> elem shiftop number '->' identifier : {extract_value('$5'), {extract_value('$2'), '$1', extract_value('$3')}}.

Erlang code.

extract_value({_Token, _Line, Value}) -> Value.
extract_token({Token, _Line}) -> Token.