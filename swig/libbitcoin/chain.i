%module "libbitcoin::chain"
%{
#include <bitcoin/bitcoin.hpp>
using namespace libbitcoin;
%}

%ignore *::operator==;
%ignore *::operator!=;

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
