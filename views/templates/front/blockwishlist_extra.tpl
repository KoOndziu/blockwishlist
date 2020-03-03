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

{if isset($wishlists) && count($wishlists) > 1}
  <div class="buttons_bottom_block no-print">
    <div id="wishlist_button">
      <select id="idWishlist">
        {foreach $wishlists as $wishlist}
          <option value="{$wishlist.id_wishlist}">{$wishlist.name}</option>
        {/foreach}
      </select>
      <button class="" onclick="WishlistCart('wishlist_block_list', 'add', '{$id_product|intval}', $('#idCombination').val(), document.getElementById('quantity_wanted').value, $('#idWishlist').val()); return false;"  title="{l s='Add to wishlist' mod='blockwishlist'}">
        {l s='Add' mod='blockwishlist'}
      </button>
    </div>
  </div>
{else}
  <p class="buttons_bottom_block no-print">
    <a id="wishlist_button" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '{$id_product|intval}', $('#idCombination').val(), document.getElementById('quantity_wanted').value); return false;" rel="nofollow"  title="{l s='Add to my wishlist' mod='blockwishlist'}">
      {l s='Add to wishlist' mod='blockwishlist'}
    </a>
  </p>
{/if}
