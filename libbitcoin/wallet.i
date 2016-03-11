#ifdef SWIGPERL
%module(package="libbitcoin::wallet") wallet
#endif
#ifdef SWIGPYTHON
%module(package="libbitcoin.wallet") wallet
#endif
%{
#undef filter_add
#undef seed

#include <bitcoin/bitcoin.hpp>
using namespace libbitcoin;
%}


%ignore *::operator==;
%ignore *::operator!=;

/*
    TODO: handle undefined symbols
*/
%ignore libbitcoin::wallet::create_token;
%ignore libbitcoin::wallet::ec_public::payment_version;
%ignore libbitcoin::wallet::ec_public::version() const;
%ignore libbitcoin::wallet::ec_public::wif_version;
%ignore libbitcoin::wallet::hd_lineage::operator<;
%ignore libbitcoin::wallet::minikey_to_secret;

%include std_except.i
%include std_vector.i
%include stdint.i

%import <bitcoin/bitcoin/compat.hpp>
%import <bitcoin/bitcoin/define.hpp>

/*
%include typemap/data_slice.i
*/
%import <bitcoin/bitcoin/utility/array_slice.hpp>
%include <bitcoin/bitcoin/utility/data.hpp>

%include <bitcoin/bitcoin/wallet/ec_public.hpp>
%include <bitcoin/bitcoin/wallet/ec_private.hpp>
%include <bitcoin/bitcoin/wallet/payment_address.hpp>
%include <bitcoin/bitcoin/wallet/stealth_address.hpp>
%include <bitcoin/bitcoin/wallet/uri.hpp>
%include <bitcoin/bitcoin/wallet/uri_reader.hpp>
%include <bitcoin/bitcoin/wallet/bitcoin_uri.hpp>
%include <bitcoin/bitcoin/wallet/dictionary.hpp>
%include <bitcoin/bitcoin/wallet/encrypted_keys.hpp>
%include <bitcoin/bitcoin/wallet/ek_private.hpp>
%include <bitcoin/bitcoin/wallet/ek_public.hpp>
%include <bitcoin/bitcoin/wallet/ek_token.hpp>
%include <bitcoin/bitcoin/wallet/hd_public.hpp>
%include <bitcoin/bitcoin/wallet/hd_private.hpp>
%include <bitcoin/bitcoin/wallet/message.hpp>
%include <bitcoin/bitcoin/wallet/mini_keys.hpp>
%include <bitcoin/bitcoin/wallet/mnemonic.hpp>
%include <bitcoin/bitcoin/wallet/qrcode.hpp>
%include <bitcoin/bitcoin/wallet/select_outputs.hpp>
%include <bitcoin/bitcoin/wallet/settings.hpp>
