#ifdef SWIGPERL
%module "libbitcoin::math"
%{
#undef filter_add
#undef seed
%}
#endif
#ifdef SWIGPYTHON
%module(package="libbitcoin.math") math
#endif
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

%import <bitcoin/bitcoin/utility/array_slice.hpp>
%include <bitcoin/bitcoin/utility/data.hpp>

%include <bitcoin/bitcoin/math/hash.hpp>
%include <bitcoin/bitcoin/math/uint256.hpp>
%include <bitcoin/bitcoin/math/hash_number.hpp>
%include <bitcoin/bitcoin/math/elliptic_curve.hpp>
%include <bitcoin/bitcoin/math/checksum.hpp>
%include <bitcoin/bitcoin/math/crypto.hpp>
%include <bitcoin/bitcoin/math/script_number.hpp>
%include <bitcoin/bitcoin/math/stealth.hpp>
