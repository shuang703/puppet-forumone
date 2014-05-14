require 'etc'
Facter.add("puppet_user") do
  confine :kernel => "Linux"
  setcode do
    Etc.getpwuid(Facter.value('host_uid').to_i).name
  end
end

Facter.add("puppet_group") do
  confine :kernel => "Linux"
  setcode do
    Etc.getgrgid(Facter.value('host_gid').to_i).name
  end
end    

Facter.add("puppet_user_home") do
  confine :kernel => "Linux"
  setcode do
    Etc.getpwuid(Facter.value('host_uid').to_i).dir
  end
end 
