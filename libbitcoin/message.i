#ifdef SWIGPERL
%module "libbitcoin::message"
%{
#undef filter_add
#undef seed
%}
#endif
#ifdef SWIGPYTHON
%module(package="libbitcoin.message") message
#endif
%{
#include <bitcoin/bitcoin.hpp>
using namespace libbitcoin;
%}

%ignore *::operator==;
%ignore *::operator!=;

/*
    TODO: handle undefined symbols from verack::to_data(writer& sink)
*/
%ignore libbitcoin::message::verack::to_data(writer& sink) const;

%include std_except.i
%include std_vector.i
%include stdint.i

%import <bitcoin/bitcoin/compat.hpp>
%import <bitcoin/bitcoin/define.hpp>

%include <bitcoin/bitcoin/message/network_address.hpp>
%include <bitcoin/bitcoin/message/address.hpp>
%include <bitcoin/bitcoin/message/alert.hpp>
%include <bitcoin/bitcoin/message/alert_payload.hpp>
%include <bitcoin/bitcoin/message/filter_add.hpp>
%include <bitcoin/bitcoin/message/filter_clear.hpp>
%include <bitcoin/bitcoin/message/filter_load.hpp>
%include <bitcoin/bitcoin/message/get_address.hpp>
%include <bitcoin/bitcoin/message/get_blocks.hpp>
%include <bitcoin/bitcoin/message/inventory_type_id.hpp>
%include <bitcoin/bitcoin/message/inventory_vector.hpp>
%include <bitcoin/bitcoin/message/inventory.hpp>
%include <bitcoin/bitcoin/message/get_data.hpp>
%include <bitcoin/bitcoin/message/get_headers.hpp>
%include <bitcoin/bitcoin/message/headers.hpp>
/*
    swig 3.0.2 has issues with the enums declared here
    TODO: %include <bitcoin/bitcoin/message/heading.hpp>
*/
%import <bitcoin/bitcoin/message/heading.hpp>
%include <bitcoin/bitcoin/message/memory_pool.hpp>
%include <bitcoin/bitcoin/message/merkle_block.hpp>
%include <bitcoin/bitcoin/message/not_found.hpp>
%include <bitcoin/bitcoin/message/nonce.hpp>
%include <bitcoin/bitcoin/message/ping.hpp>
%include <bitcoin/bitcoin/message/pong.hpp>
%include <bitcoin/bitcoin/message/reject.hpp>
%include <bitcoin/bitcoin/message/verack.hpp>
%include <bitcoin/bitcoin/message/version.hpp>
