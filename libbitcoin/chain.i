#ifdef SWIGPERL
%module "libbitcoin::chain"
%{
#undef seed
%}
#endif
#ifdef SWIGPYTHON
%module(package="libbitcoin.chain") chain
#endif
%{
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

/*
including data_slice defintion is needed to address
src/libbitcoin/chain_wrap.cxx:6475:16: error: no matching function for call to ‘libbitcoin::array_slice<unsigned char>::array_slice()’
     data_slice arg1 ;
*/
%import <bitcoin/bitcoin/utility/array_slice.hpp>
%include <bitcoin/bitcoin/utility/data.hpp>

%include <bitcoin/bitcoin/chain/header.hpp>
%include <bitcoin/bitcoin/chain/point.hpp>
%include <bitcoin/bitcoin/chain/opcode.hpp>
%include <bitcoin/bitcoin/chain/operation.hpp>
%include <bitcoin/bitcoin/chain/script.hpp>
%include <bitcoin/bitcoin/chain/input.hpp>
%include <bitcoin/bitcoin/chain/output.hpp>
%include <bitcoin/bitcoin/chain/transaction.hpp>
%include <bitcoin/bitcoin/chain/block.hpp>
