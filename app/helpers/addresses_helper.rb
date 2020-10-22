module AddressesHelper
  def left_count(count)
    count == 0 ? '最大件数登録済みです' : "あと#{count}件登録可能です"
  end
end

