describe Badge do

  it { should respond_to(:position=, :position)}
  it { should respond_to(:icon=, :icon)}
  it { should respond_to(:icon_color=, :icon_color)}
  it { should respond_to(:identifier=, :identifier)}

end