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

%import <bitcoin/bitcoin/chain/block.hpp>
