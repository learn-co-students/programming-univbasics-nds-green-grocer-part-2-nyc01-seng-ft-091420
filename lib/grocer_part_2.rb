require_relative './part_1_solution.rb'

require 'pry'

# returns a new Array.
# Its members will be a mix of the item Hashes and, where applicable, the "ITEM W/COUPON" Hash.
def apply_coupons(cart, coupons)
  i = 0
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
    if item_is_in_basket and count_is_big_enough_to_apply
      cart << { item: "#{item_with_coupon[:item]} W/COUPON",
                price: coupon[:cost] / coupon[:num],
                clearance: item_with_coupon[:clearance],
                count: coupon[:num]
              }
      item_with_coupon[:count] -= coupon[:num]
    end
    i += 1
  end
  cart
end

  # REMEMBER: This method **should** update cart

def apply_clearance(cart)
  counter = 0
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] * 0.8).round(2)
      end
      counter += 1
    end
    cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(applied_coupons)
  total_price = 0
  counter = 0
  while counter < final_cart.length
    total_price += (final_cart[counter][:price] * final_cart[counter][:count])
    counter += 1
  end
  if total_price > 100
    total_price = (total_price * 0.9).round(2)
  end
  total_price
end
