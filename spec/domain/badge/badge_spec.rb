describe Badge do

  it { is_expected.to respond_to(:position=, :position)}
  it { is_expected.to respond_to(:icon=, :icon)}
  it { is_expected.to respond_to(:icon_color=, :icon_color)}
  it { is_expected.to respond_to(:identifier=, :identifier)}

end