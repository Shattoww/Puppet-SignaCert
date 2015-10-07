Facter.add(:signacertinstalled) do
        setcode do
                File.directory?('/opt/sigancert/')
        end
end
