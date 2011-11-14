require 'boxgrinder-core/models/appliance-config'
require 'boxgrinder-build/plugins/base-plugin'
require 'boxgrinder-core/errors'

module BoxGrinder
  class UbuntuPlugin < BasePlugin
    def after_init
      register_deliverable(
          :disk => "#{@appliance_config.name}-sda.qcow2"
      )
      register_supported_os('ubuntu', ["natty"])
    end

    def execute(appliance_definition_file)
      execute_vmbuilder
    end

    def validate
      set_default_config_value('format', 'qcow2')
    end

    def create_files_map
      if @appliance_config.files and not @appliance_config.files.empty? 
        @log.debug "Creting temporal file list #{@dir.tmp + '/filelist'}"
        file_lies = File.open(@dir.tmp + "/filelist", 'w') do |fl|
          @appliance_config.files.each do |dir, files|
            files.each do |f| 
              fl.puts "#{f} #{dir}/#{f}"
            end
          end
        end
        true
      else
        false
      end
    end
    
    def create_partitions_file
      pcount = 1
      plist = File.open(@dir.tmp + "/partitions", 'w') do |pl|
        @log.debug "Creting partition map  #{@dir.tmp + '/partitions'}"
        @appliance_config.hardware.partitions.each do |mpoint, values|
          pl.puts "#{mpoint} #{values['size'].to_i * 1024}"
        end
      end
      @dir.tmp + "/partitions"
    end

    def execute_vmbuilder
      arch = @appliance_config.hardware.arch
      arch = 'amd64' if  arch == 'x86_64'
      pkgs = @appliance_config.packages.map { |p| "--addpkg #{p}" }
      extra_args = []
      if create_files_map
        extra_args << "--copy #{@dir.tmp + '/filelist'}"
      end
      extra_args << "--part #{create_partitions_file}"
      extra_args << "--rootpass #{@appliance_config.os.password}"
      if ENV["BOXGRINDER_DEBUG_VMBUILDER"]
        extra_args << "--debug"
      else
        extra_args << '--quiet'
      end

      begin
        @exec_helper.execute "vmbuilder kvm ubuntu #{extra_args.join(' ')} --suite #{@appliance_config.os.version} #{pkgs.join(" ")} --arch #{arch} -t '#{@dir.tmp}' -d '#{@dir.base}/out' --mem #{@appliance_config.hardware.memory} --cpus #{@appliance_config.hardware.cpus}"
        #
        # Move resulting disk image to the plugin output dir
        #
        dsource = Dir["#{@dir.base}/out/*.qcow2"].first
        ddest = "#{@dir.base}/tmp/#{@appliance_config.name}-sda.qcow2"
        @log.debug "Moving qcow2 disk image from #{dsource} to #{ddest}"
        FileUtils.mv dsource, ddest
        @log.debug "Ubuntu appliance ready"
      rescue => e
      ensure
        #
        # Cleanup
        #
        # Set env var BOXGRINDER_DEBUG_NOCLEAN if you down't want to clean
        # tmp/out dirs (useful for debugging)
        #
        if not ENV["BOXGRINDER_DEBUG_NOCLEAN"]
          @log.debug "Cleaning tmp/work directories"
          FileUtils.rm_rf "#{@dir.base}/out" if File.exist? "#{@dir.base}/out"
        end
      end
    end

  end
end

plugin :class => BoxGrinder::UbuntuPlugin, :type => :os, :name => :ubuntu, :full_name => "Ubuntu", :versions => ["lucid", "maveric", "natty", "oneiric"]

