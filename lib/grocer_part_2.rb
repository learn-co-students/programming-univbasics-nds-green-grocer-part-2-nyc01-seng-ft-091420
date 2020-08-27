require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  if !coupons
    return "No coupons!"
  else
    coupons.each do |coupon|
      if find_item_by_name_in_collection(coupon[:item], cart)
        cart_item = find_item_by_name_in_collection(coupon[:item], cart)
        if cart_item[:count] >= coupon[:num]
          
          # add new item w/ coupon to array
          cart << {:item => "#{cart_item[:item]} W/COUPON", :price => (coupon[:cost] / coupon[:num]), :clearance => cart_item[:clearance], :count => coupon[:num]}
        
          #subtract from original item count in array
          cart_item[:count] -= coupon[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end
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

  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  
  total = 0
  cart.each do |item|
    total += (item[:price] * item[:count])
  end

  if total > 100
    total = (total * 0.9).round(2)
  end
  
  total
end
