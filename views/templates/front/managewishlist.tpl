{if $products}
    {if !$refresh}
        <div class="wishlistLinkTop">
        <a id="hideWishlist" class="button_account icon pull-right" href="#" onclick="WishlistVisibility('wishlistLinkTop', 'Wishlist'); return false;" rel="nofollow" title="{l s='Close this wishlist' mod='blockwishlist'}">
            <i class="material-icons">clear</i>
        </a>
        <ul class="clearfix display_list">
            <li>
                <a  id="hideBoughtProducts" class="button_account" href="#" onclick="WishlistVisibility('wlp_bought', 'BoughtProducts'); return false;" title="{l s='Hide products' mod='blockwishlist'}">
                    {l s='Hide products' mod='blockwishlist'}
                </a>
                <a id="showBoughtProducts" class="button_account" href="#" onclick="WishlistVisibility('wlp_bought', 'BoughtProducts'); return false;" title="{l s='Show products' mod='blockwishlist'}">
                    {l s='Show products' mod='blockwishlist'}
                </a>
            </li>
            {if count($productsBoughts)}
                <li>
                    <a id="hideBoughtProductsInfos" class="button_account" href="#" onclick="WishlistVisibility('wlp_bought_infos', 'BoughtProductsInfos'); return false;" title="{l s='Hide products' mod='blockwishlist'}">
                        {l s="Hide bought products' info" mod='blockwishlist'}
                    </a>
                    <a id="showBoughtProductsInfos" class="button_account" href="#" onclick="WishlistVisibility('wlp_bought_infos', 'BoughtProductsInfos'); return false;" title="{l s='Show products' mod='blockwishlist'}">
                        {l s="Show bought products' info" mod='blockwishlist'}
                    </a>
                </li>
            {/if}
        </ul>
        <p class="wishlisturl form-group">
            <label>{l s='Permalink' mod='blockwishlist'}:</label> 
            <input type="text" class="form-control" value="{url entity='module' name='blockwishlist' controller='view' params=['token' => $token_wish]}" readonly="readonly"/>
        </p>
        <p class="submit">
            <div id="showSendWishlist">
                <a class="btn btn-default button button-small" href="#" onclick="WishlistVisibility('wl_send', 'SendWishlist'); return false;" title="{l s='Send this wishlist' mod='blockwishlist'}">
                    <span>{l s='Send this wishlist' mod='blockwishlist'}</span>
                </a>
            </div>
        </p>
    {/if}
    <div class="wlp_bought">
        {assign var='nbItemsPerLine' value=4}
        {assign var='nbItemsPerLineTablet' value=3}
        {assign var='nbLi' value=$products|@count}
        {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
        {math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
        <ul class="row wlp_bought_list">
            {foreach from=$products item=product name=i}
                {math equation="(total%perLine)" total=$smarty.foreach.i.total perLine=$nbItemsPerLine assign=totModulo}
                {math equation="(total%perLineT)" total=$smarty.foreach.i.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
                {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                {if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
                <li id="wlp_{$product.id_product}_{$product.id_product_attribute}"
                    class="col-xs-12 col-sm-4 col-md-3 {if $smarty.foreach.i.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLine == 1} first-in-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModulo)}last-line{/if} {if $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 0}last-item-of-tablet-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 1}first-item-of-tablet-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModuloTablet)}last-tablet-line{/if}">
                    <div class="row">
                        <div class="col-xs-6 col-sm-12">
                            <div class="product_image">
                                
                                <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" title="{l s='Product detail' mod='blockwishlist'}">
                                    <img class="replace-2x img-responsive"  src="//{$product.image_link}" alt="{$product.name|escape:'html':'UTF-8'}"/>
                                </a>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-12">
                            <div class="product_infos">
                                <a class="lnkdel" href="javascript:;" onclick="WishlistProductManage('wlp_bought', 'delete', '{$id_wishlist}', '{$product.id_product}', '{$product.id_product_attribute}', $('#quantity_{$product.id_product}_{$product.id_product_attribute}').val(), $('#priority_{$product.id_product}_{$product.id_product_attribute}').val());" title="{l s='Delete' mod='blockwishlist'}">
                                    <i class="icon-remove-sign"></i>
                                </a>

                                <p id="s_title" class="product-name">
                                    {$product.name|truncate:30:'...'|escape:'html':'UTF-8'}
                                    {if isset($product.attributes_small)}
                                        <small>
                                            <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" title="{l s='Product detail' mod='blockwishlist'}">
                                                {$product.attributes_small|escape:'html':'UTF-8'}
                                            </a>
                                        </small>
                                    {/if}
                                </p>
                                <div class="wishlist_product_detail">
                                    <p class="form-group">
                                        <label for="quantity_{$product.id_product}_{$product.id_product_attribute}">
                                            {l s='Quantity' mod='blockwishlist'}:
                                        </label>
                                        <input type="text" class="form-control grey" id="quantity_{$product.id_product}_{$product.id_product_attribute}" value="{$product.quantity|intval}" size="3"/>
                                    </p>

                                    <p class="form-group">
                                        <label for="priority_{$product.id_product}_{$product.id_product_attribute}">
                                            {l s='Priority' mod='blockwishlist'}:
                                        </label>
                                        <select id="priority_{$product.id_product}_{$product.id_product_attribute}" class="form-control grey">
                                            <option value="0"{if $product.priority eq 0} selected="selected"{/if}>
                                                {l s='High' mod='blockwishlist'}
                                            </option>
                                            <option value="1"{if $product.priority eq 1} selected="selected"{/if}>
                                                {l s='Medium' mod='blockwishlist'}
                                            </option>
                                            <option value="2"{if $product.priority eq 2} selected="selected"{/if}>
                                                {l s='Low' mod='blockwishlist'}
                                            </option>
                                        </select>
                                    </p>
                                </div>
                                <div class="btn_action">
                                    <a class="btn btn-default button button-small"  href="javascript:;" onclick="WishlistProductManage('wlp_bought_{$product.id_product_attribute}', 'update', '{$id_wishlist}', '{$product.id_product}', '{$product.id_product_attribute}', $('#quantity_{$product.id_product}_{$product.id_product_attribute}').val(), $('#priority_{$product.id_product}_{$product.id_product_attribute}').val());" title="{l s='Save' mod='blockwishlist'}">
                                        <span>{l s='Save' mod='blockwishlist'}</span>
                                    </a>
                                    {if $wishlists|count > 1}
                                        {foreach name=wl from=$wishlists item=wishlist}
                                            {if $smarty.foreach.wl.first}
                                                <a class="btn btn-default button button-small wishlist_change_button" tabindex="0" data-toggle="popover" data-trigger="focus" title="{l s='Move to a wishlist' mod='blockwishlist'}" data-placement="bottom">
                                                    <span>{l s='Move' mod='blockwishlist'}</span>
                                                    </a>
                                                    <div hidden class="popover-content">
                                                        <table class="table" border="1">
                                                            <tbody>
                                            {/if}
                                            {if $id_wishlist != {$wishlist.id_wishlist}}
                                                                <tr title="{$wishlist.name|escape:'html':'UTF-8'}" value="{$wishlist.id_wishlist}" onclick="wishlistProductChange({$product.id_product}, {$product.id_product_attribute}, '{$id_wishlist}', '{$wishlist.id_wishlist}');">
                                                                    <td>
                                                                        {l s='Move to %s'|sprintf:$wishlist.name mod='blockwishlist'}
                                                                    </td>
                                                                </tr>
                                            {/if}
                                            {if $smarty.foreach.wl.last}
                                                        </tbody>
                                                    </table>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            {/foreach}
        </ul>
    </div>
    {if !$refresh}
        <form method="post" class="wl_send box unvisible" onsubmit="return (false);">
        <a id="hideSendWishlist" class="button_account btn icon"  href="#" onclick="WishlistVisibility('wl_send', 'SendWishlist'); return false;" rel="nofollow" title="{l s='Close this wishlist' mod='blockwishlist'}">
            <i class="material-icons">clear</i>
        </a>
            <fieldset>
                <div class="required form-group">
                    <label for="email1">{l s='Email' mod='blockwishlist'}1 <sup>*</sup></label>
                    <input type="text" name="email1" id="email1" class="form-control"/>
                </div>
                {section name=i loop=11 start=2}
                    <div class="form-group">
                        <label for="email{$smarty.section.i.index}">{l s='Email' mod='blockwishlist'}{$smarty.section.i.index}</label>
                        <input type="text" name="email{$smarty.section.i.index}" id="email{$smarty.section.i.index}"
                               class="form-control"/>
                    </div>
                {/section}
                <div class="submit">
                    <button class="btn btn-default button button-small" type="submit" name="submitWishlist"
                            onclick="WishlistSend('wl_send', '{$id_wishlist}', 'email');">
                        <span>{l s='Send' mod='blockwishlist'}</span>
                    </button>
                </div>
                <p class="required">
                    <sup>*</sup> {l s='Required field' mod='blockwishlist'}
                </p>
            </fieldset>
        </form>
        {if count($productsBoughts)}
            <table class="wlp_bought_infos unvisible table table-bordered table-responsive">
                <thead>
                <tr>
                    <th class="first_item">{l s='Product' mod='blockwishlist'}</th>
                    <th class="item">{l s='Quantity' mod='blockwishlist'}</th>
                    <th class="item">{l s='Offered by' mod='blockwishlist'}</th>
                    <th class="last_item">{l s='Date' mod='blockwishlist'}</th>
                </tr>
                </thead>
                <tbody>
                {foreach from=$productsBoughts item=product name=i}
                    {foreach from=$product.bought item=bought name=j}
                        {if $bought.quantity > 0}
                            <tr>
                                <td class="first_item">
									<span style="float:left;">
										<img
                                                src="//{$product.image_link}"
                                                alt="{$product.name|escape:'html':'UTF-8'}"/>
									</span>
									<span style="float:left;">
										{$product.name|truncate:40:'...'|escape:'html':'UTF-8'}
                                        {if isset($product.attributes_small)}
                                            <br/>
                                            <i>{$product.attributes_small|escape:'html':'UTF-8'}</i>
                                        {/if}
									</span>
                                </td>
                                <td class="item align_center">
                                    {$bought.quantity|intval}
                                </td>
                                <td class="item align_center">
                                    {$bought.firstname} {$bought.lastname}
                                </td>
                                <td class="last_item align_center">
                                    {$bought.date_add|date_format:"%Y-%m-%d"}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                {/foreach}
                </tbody>
            </table>
        {/if}
    {/if}
{else}
    <p class="alert alert-warning">
        {l s='No products' mod='blockwishlist'}
    </p>
{/if}
