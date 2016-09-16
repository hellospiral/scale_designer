FactoryGirl.define do
  factory(:scale) do
   name('Something')
  end

  factory(:note) do
    frequency(1200)
  end
end
