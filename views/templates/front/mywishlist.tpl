{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='My wishlists' mod='blockwishlist'}
{/block}

{block name='breadcrumb_item'}
  {$smarty.block.parent}
  <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
    <a itemprop="item" href="{url entity='module' name='blockwishlist' controller='mywishlist'}">
      <span itemprop="name">{l s='Wishlist' mod='blockwishlist'}</span>
    </a>
  </li>	
{/block}

{block name="page_content"}
  <h6>{l s='New wishlist' mod='blockwishlist'}</h6>
  <div id="mywishlist" class="block_wishlist">
    {if isset($errors) && $errors}
      <div class="alert alert-danger" role="alert">
        <ol>
          {foreach from=$errors key=k item=error}
            <li>{$error}</li>
            {/foreach}
        </ol>
      </div>
    {/if}

    {if $id_customer|intval neq 0}
      <form method="post" class="std box" id="form_wishlist">
        <p>
          <button name="submitWishlist" type="submit" id="submitWishlist" class="btn btn-primary float-xs-right hidden-xs-down" >
            <span>{l s='Save' mod='blockwishlist'}</span>
          </button>
        <div class="input-wrapper">
          <input 
            name="name" 
            type="text" 
            id="name" 
            class="inputTxt form-control" 
            value="{if isset($smarty.post.name) and $errors|@count > 0}{$smarty.post.name|escape:'html':'UTF-8'}{/if}"
            placeholder="{l s='Name' mod='blockwishlist'}"
            >						
        </div>
        <input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}" />
        <div class="clearfix"></div>
        </p>
      </form>

      {if $wishlists}
        <h6>{l s='Wishlists' mod='blockwishlist'}</h6>
        <div id="block-history" class="block-center">
          <table class="table table-striped table-bordered table-labeled">
            <thead class="thead-default">
              <tr>
                <th class="first_item">{l s='Name' mod='blockwishlist'}</th>
                <th class="item mywishlist_first">{l s='Qty' mod='blockwishlist'}</th>
                <th class="item mywishlist_first">{l s='Viewed' mod='blockwishlist'}</th>
                <th class="item mywishlist_second">{l s='Created' mod='blockwishlist'}</th>
                <th class="item mywishlist_second">{l s='Direct Link' mod='blockwishlist'}</th>
                <th class="item mywishlist_second">{l s='Default' mod='blockwishlist'}</th>
                <th class="last_item mywishlist_first">{l s='Delete' mod='blockwishlist'}</th>
              </tr>
            </thead>
            <tbody>
              {section name=i loop=$wishlists}
                <tr id="wishlist_{$wishlists[i].id_wishlist|intval}">
                  <td style="width:200px;">
                    <a href="#" onclick="javascript:event.preventDefault();
                        WishlistManage('block-order-detail', '{$wishlists[i].id_wishlist|intval}');">
                      {$wishlists[i].name|truncate:30:'...'|escape:'htmlall':'UTF-8'}
                    </a>
                  </td>
                  <td class="bold align_center">
                    {assign var=n value=0}
                    {foreach from=$nbProducts item=nb name=i}
                      {if $nb.id_wishlist eq $wishlists[i].id_wishlist}
                        {assign var=n value=$nb.nbProducts|intval}
                      {/if}
                    {/foreach}
                    {if $n}
                      {$n|intval}
                    {else}
                      0
                    {/if}
                  </td>
                  <td>{$wishlists[i].counter|intval}</td>
                  <td>{$wishlists[i].date_add|date_format:"%Y-%m-%d"}</td>
                  <td>
                    <a href="#" onclick="javascript:event.preventDefault();
                        WishlistManage('block-order-detail', '{$wishlists[i].id_wishlist|intval}');">
                      {l s='View' mod='blockwishlist'}
                    </a>
                  </td>
                  <td class="wishlist_default">
                    {if isset($wishlists[i].default) && $wishlists[i].default == 1}
                      <p class="is_wish_list_default">
                        <i class="material-icons">check_box</i>
                      </p>
                    {else}
                      <a href="#" onclick="javascript:event.preventDefault();
                          (WishlistDefault('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}'));">
                        <i class="material-icons">check_box_outline_blank</i>
                      </a>
                    {/if}
                  </td>
                  <td class="wishlist_delete">
                    <a class="icon" href="#" onclick="javascript:event.preventDefault();
                        return (WishlistDelete('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}', '{l s='Do you really want to delete this wishlist ?' mod='blockwishlist' js=1}'));">
                      <i class="material-icons">clear</i>
                    </a>
                  </td>
                </tr>
              {/section}
            </tbody>
          </table>
        </div>
        <div id="block-order-detail">&nbsp;</div>
      {/if}
    {/if}
  </div>
{/block}