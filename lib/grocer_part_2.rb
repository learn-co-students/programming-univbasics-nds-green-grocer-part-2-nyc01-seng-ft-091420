require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
# should update cart

#iterate through coupons in case multiple coupons are being applied
  i = 0 
  while i < coupons.length do 
    
#find matching item in cart, return cart if no match is found

    cart.each do |element|

#only apply coupon if coupon :num is greater than or equal to cart count
#update quantity of matching item in cart 
#add item + /W COUPON to cart

      if element[:item] == coupons[i][:item] && element[:count] >= coupons[i][:num]
        element[:count] = element[:count] - coupons[i][:num]
        cart << {:item => coupons[i][:item].to_s + " W/COUPON", 
                  :price => coupons[i][:cost]/coupons[i][:num], 
                  :clearance => element[:clearance], 
                  :count => coupons[i][:num]}
      end
    end
    i += 1
  end

  #THIS DELETES ITEMS WITH A 0 COUNT BUT MAKES MY CODE FAIL
#  cart.each do |element|
#    if element[:count] == 0 
#      cart.delete(element)
#    end
#  end

  cart
end

def apply_clearance(cart)
  cart.each do |element|
    if element[:clearance] == true 
      element[:price] = (element[:price] - element[:price] * 0.2).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  only_coupons = apply_coupons(consolidate_cart(cart), coupons)
  final = apply_clearance(only_coupons)
  total = 0
  final.each do |element| 
    total += (element[:price] * element[:count]).round(2)
    end
  if total > 100
    total = (total - total * 0.1).round(2)
  end
  total
end
