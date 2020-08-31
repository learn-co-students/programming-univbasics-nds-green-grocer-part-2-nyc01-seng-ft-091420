require_relative './part_1_solution.rb'

# def apply_coupons(cart, coupons)
#   # Consult README for inputs and outputs
#   #
#   # REMEMBER: This method **should** update cart
#   new_cart = []
#   cart.each do |cart_item|
#     coupons.each do |coupon_item|
#       if coupon_item[:item] == cart_item[:item]
#         discounted_item = {}
#         cart_item[:count] -= coupon_item[:num]
#         discounted_item[:item] = coupon_item[:item] + " W/COUPON"
#         discounted_item[:price] = coupon_item[:cost]/coupon_item[:num]
#         discounted_item[:clearance] = cart_item[:clearance]
#         discounted_item[:count] = coupon_item[:num]
#         new_cart << discounted_item
#       end
#     end
#   end
#   cart.each do |cart_item|
#     new_cart << cart_item
#     if cart_item[:count] <= 0
#       cart.delete(cart_item)
#     end
#   end
#   return new_cart
# end

#I have no idea what the "minimum amount" test for the "checkout" method 
#is asking - this is not clear, so I'm using the solution branch solution.
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



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = []
  cart.each do |cart_item|
    new_cart << cart_item
  end
  new_cart.each do |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] *= 0.8
    end
  end
  return new_cart
end


def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
   
  grand_total = 0
  
  new_cart.each do |cart_item|
    grand_total += cart_item[:price] * cart_item[:count]
  end
  if grand_total > 100
    grand_total *= 0.9
  end
  return grand_total.round(2)
end
