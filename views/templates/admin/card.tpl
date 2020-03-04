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

<div class="col">
  <div class="card">
    <h3 class="card-header">
      <i class="material-icons">favorites</i>
      {$card.title}
    </h3>
    <div class="card-body">
      
      {if isset($card.wishlists) && count($card.wishlists) != 0}
        <p>
          <form action="{$card.action}" method="post" id="listing">
            <label>{l s='Wishlist' mod='blockwishlist'}: </label>
            <select data-toggle="select2" name="id_wishlist" onchange="$('#listing').submit();">
              {foreach $card.wishlists as $wishlist}
                <option 
                  value="{$wishlist.id_wishlist}"
                  {if $wishlist.id_wishlist == $card.current_wishlist}selected{/if}
                  >{$wishlist.name}
                </option>
              {/foreach}
            </select>
          </form>
        </p>
        
        {if count($products) != 0}
          {include file="module:blockwishlist/views/templates/admin/blockwishlist_table.tpl" }
        {else}
          <div class="alert alert-info" role="alert">
            <p class="alert-text">{l s='No products.' mod='blockwishlist'}</p>  
          </div>
        {/if}
      {else}
        <div class="alert alert-info" role="alert">
          <p class="alert-text">{l s='No wishlist.' mod='blockwishlist'}</p>  
        </div>
      {/if}
    </div>
  </div>
</div>