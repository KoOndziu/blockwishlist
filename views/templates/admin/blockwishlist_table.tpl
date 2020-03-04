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

<table class="table">
  <thead>
    <tr>
      <th class="first_item">{l s='Product' mod='blockwishlist'} ({$products|count})</th>
      <th class="item"></th>
      <th class="item">{l s='Quantity' mod='blockwishlist'}</th>
      <th class="item">{l s='Priority' mod='blockwishlist'}</th>
    </tr>
  </thead>
  <tbody>
    {foreach $products as $product}
      <tr>
        <td>
          <img style="max-width: 50px" src="{$product.cover}" alt="{$product.name}" class="imgm img-thumbnail">
        </td>
        <td class="first_item">
          {$product.name}<br>{$product.attributes}
        </td>
        <td class="item">{$product.quantity}</td>
        <td class="item">{$product.priority_label}</td>
      </tr>
    {/foreach}
  </tbody>
</table>
