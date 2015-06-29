Facter.add(:signacertinstalled) do
        setcode do
                File.directory?('/opt/sigancert/')
		  'yes'
        end
end
