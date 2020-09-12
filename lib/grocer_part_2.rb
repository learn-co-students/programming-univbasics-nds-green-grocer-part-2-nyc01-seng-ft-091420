require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
cart.each do |item|
  coupons.each do |citem|
    if item[:item] == citem[:item]
      if item[:count] == citem[:num]
        wit_coup=item.dup
        wit_coup[:item]="#{item[:item]} W/COUPON"
        wit_coup[:price]=citem[:cost]/citem[:num]
        item[:count] = item[:count]-citem[:num]
        cart<<wit_coup
      elsif item[:count] > citem[:num]
        wit_coup=item.dup
        wit_coup[:item]="#{item[:item]} W/COUPON"
        wit_coup[:price]=citem[:cost]/citem[:num]
        item[:count]=item[:count]-citem[:num]
        wit_coup[:count]=citem[:num]
        cart<<wit_coup
      else
        cart


  # Consult README for inputs alearnd outputs
  #.dup copys w.e u want so u can use it to copy the item hash
  # REMEMBER: This method **should** update cart
end
end
end
end
cart
end


def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]==true
      item[:price]=item[:price]-(item[:price] * 0.20)
    end
  end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end




def checkout(cart, coupons)
  newcart=consolidate_cart(cart)
  apply_coupons(newcart, coupons)
  apply_clearance(newcart)
  sum = 0
  newcart.each do |item|
    product=item[:price] * item[:count]
    sum=product + sum
    sum=sum.round(2)
  end
  if sum > 100
    discount=sum * 0.10
    sum=sum-discount
  end
  sum
end
