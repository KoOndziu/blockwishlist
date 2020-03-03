{*
* 2015-2020 Ko_Ondziu
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author    Ko_Ondziu <000konrad000@gmail.com>
* @copyright 2015-2020 Ko_Ondziu
* @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
*}

<script type="text/javascript">
  console.log({$wishlist_products|json_encode nofilter});
  var wishlistProductsIds = {$wishlist_products|json_encode nofilter};
  var loggin_required = "{l s='You must be logged in to manage your wishlist.' mod='blockwishlist' js=1}";
  var added_to_wishlist = "{l s='The product was successfully added to your wishlist.' mod='blockwishlist' js=1}";
  var mywishlist_url = "{url entity='module' name='blockwishlist' controller='mywishlist'}";

  {if $customer.is_logged}
  var isLoggedWishlist = true
  {else}
  var isLoggedWishlist = false
  {/if}
</script>