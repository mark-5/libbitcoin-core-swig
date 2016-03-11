#ifdef SWIGPERL
%module(package="libbitcoin::chain") chain
#endif
#ifdef SWIGPYTHON
%module(package="libbitcoin.chain") chain
#endif
%{
#undef seed

#include <bitcoin/bitcoin.hpp>
using namespace libbitcoin;
%}

/*
    TODO: handle operator overloading
*/
%ignore *::operator==;
%ignore *::operator!=;
/*
    TODO: handle undefined symbols from satoshi_fixed_size
*/
%ignore libbitcoin::chain::input::satoshi_fixed_size;
%ignore libbitcoin::chain::output::satoshi_fixed_size;
%ignore libbitcoin::chain::transaction::satoshi_fixed_size;

%include std_except.i
%include std_vector.i
%include stdint.i

%import <bitcoin/bitcoin/compat.hpp>
%import <bitcoin/bitcoin/define.hpp>

%include <bitcoin/bitcoin/chain/header.hpp>
%include <bitcoin/bitcoin/chain/point.hpp>
%include <bitcoin/bitcoin/chain/opcode.hpp>
/* TODO: %include <bitcoin/bitcoin/chain/operation.hpp> */
%import <bitcoin/bitcoin/chain/operation.hpp>
%include <bitcoin/bitcoin/chain/script.hpp>
%include <bitcoin/bitcoin/chain/input.hpp>
%include <bitcoin/bitcoin/chain/output.hpp>
%include <bitcoin/bitcoin/chain/transaction.hpp>
%include <bitcoin/bitcoin/chain/block.hpp>
