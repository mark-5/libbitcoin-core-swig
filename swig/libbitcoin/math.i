%module "libbitcoin::math"
%{
#undef filter_add
#undef seed

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

%import <bitcoin/bitcoin/math/hash.hpp>
%import <bitcoin/bitcoin/math/uint256.hpp>
%import <bitcoin/bitcoin/math/hash_number.hpp>
%import <bitcoin/bitcoin/math/elliptic_curve.hpp>
%import <bitcoin/bitcoin/math/checksum.hpp>
%import <bitcoin/bitcoin/math/crypto.hpp>
%import <bitcoin/bitcoin/math/script_number.hpp>
%import <bitcoin/bitcoin/math/stealth.hpp>
