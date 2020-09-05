require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupon_cart = []
  cart.each do |item|
    coupons.each do |coupon_item|
      if item[:item] == coupon_item[:item] && item[:count] >= coupon_item[:num]
        uncouponed = item[:count] % coupon_item[:num]
        couponed = item[:count] - uncouponed
        item[:count] = uncouponed
        coupon_price_per = coupon_item[:cost] / coupon_item[:num]
        coupon_cart << {:item => "#{item[:item]} W/COUPON", :price => coupon_price_per, :clearance => item[:clearance], :count => couponed}
      end
    end
    coupon_cart << item
  end
  coupon_cart
end

def apply_clearance(cart)
  cart.collect do |item|
    if item[:clearance]
      item[:price] *= 0.8
      item[:price].round(2)
    end
    item
  end
end

def checkout(cart, coupons)
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  final_cart.each do |item|
    total += item[:price] * item[:count]
  end
  total *= 0.9 if total > 100
  total.round(2)
end