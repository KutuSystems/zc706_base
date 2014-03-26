##################
# Primary Clocks #
##################

# Differential input clock from SI570 clock synthesizer on ZC702
# Constrained to 148.5MHz (1080p60 video resolution)
# create_clock -period 6.734 -name video_clk [get_ports video_clk_p]

####################
# Generated Clocks #
####################

# Rename auto-generated clocks from MMCM
# create_generated_clock -name clk_100mhz [get_pins system_top_wrapper_1/system_top_i/Zynq_1/processing_system7_1/U0/PS7_i/FCLKCLK[0]]
# create_generated_clock -name clk_200mhz [get_pins system_top_wrapper_1/system_top_i/Zynq_1/processing_system7_1/U0/PS7_i/FCLKCLK[1]]
create_clock -period 10.0 -name clk_100mhz [get_pins system_top_wrapper_1/system_top_i/Zynq_1/processing_system7_1/U0/PS7_i/FCLKCLK[0]]
create_clock -period 5.0 -name clk_200mhz [get_pins system_top_wrapper_1/system_top_i/Zynq_1/processing_system7_1/U0/PS7_i/FCLKCLK[1]]

create_generated_clock -name clk_spdif [get_pins system_top_wrapper_1/system_top_i/Zynq_1/clk_wiz_0/U0/mmcm_adv_inst/CLKOUT0]

create_generated_clock -name clk_ref_hdmi [get_pins system_top_wrapper_1/system_top_i/Video_Display/axi_clkgen_0/U0/USER_LOGIC_I/i_clkgen/i_mmcm/CLKOUT0]

################
# Clock Groups #
################

# video_clk is generated by SI570 clock synthesizer and clk_100mhz/clk_200mhz by MMCM
# There is no known phase relationship, hence they are treated  as asynchronous
# clk_spdif is generated from clk75mhz, but is effectively asynchronous 
set_clock_groups -name async_clks -asynchronous -group {clk_100mhz} -group {clk_200mhz} -group {clk_spdif} -group {clk_ref_hdmi}

#############
# I/O Delay #
#############

#  2ns of output delay for HDMI output
set_output_delay -clock clk_ref_hdmi -min 2.000 [get_ports hdmio_data*]


set_switching_activity -static_probability 1 -signal_rate 0 [get_nets system_top_wrapper_1/system_top_i/Zynq_1/proc_sys_reset_1/U0/peripheral_reset[0]]
set_switching_activity -static_probability 1 -signal_rate 0 [get_nets system_top_wrapper_1/system_top_i/Video_Display/axi_clkgen_0/n_0_U0/USER_LOGIC_I/i_clkgen/mmcm_rst_reg]

########################
# Physical Constraints #
########################

# Clock Synthesizer (SI570) on ZC706 (currently not used)
# set_property PACKAGE_PIN AF14 [get_ports video_clk_p]
# set_property IOSTANDARD LVDS_25 [get_ports video_clk_p]

# set_property PACKAGE_PIN AG14 [get_ports video_clk_n]
# set_property IOSTANDARD LVDS_25 [get_ports video_clk_n]

# AXI I2C on ZC706 
set_property PACKAGE_PIN AJ18 [get_ports iic_sda_io]
set_property IOSTANDARD LVCMOS25 [get_ports iic_sda_io]

set_property PACKAGE_PIN AJ14 [get_ports iic_scl_io]
set_property IOSTANDARD LVCMOS25 [get_ports iic_scl_io]

# HDMI SPDIF Output (ADV7511) on ZC706 
set_property PACKAGE_PIN AC21 [get_ports spdif_tx]
set_property IOSTANDARD LVCMOS25 [get_ports spdif_tx]

# HDMI Output (ADV7511) on ZC706 
set_property PACKAGE_PIN P28 [get_ports hdmio_clk]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_clk]

set_property PACKAGE_PIN V24 [get_ports hdmio_de]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_de]

set_property PACKAGE_PIN R22 [get_ports hdmio_hsync]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_hsync]

set_property PACKAGE_PIN U21 [get_ports hdmio_vsync]
set_property IOSTANDARD LVCMOS25 [get_ports hdmio_vsync]

set_property PACKAGE_PIN U24 [get_ports {hdmio_data[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[0]}]

set_property PACKAGE_PIN T22 [get_ports {hdmio_data[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[1]}]

set_property PACKAGE_PIN R23 [get_ports {hdmio_data[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[2]}]

set_property PACKAGE_PIN AA25 [get_ports {hdmio_data[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[3]}]

set_property PACKAGE_PIN AE28 [get_ports {hdmio_data[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[4]}]

set_property PACKAGE_PIN T23 [get_ports {hdmio_data[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[5]}]

set_property PACKAGE_PIN AB25 [get_ports {hdmio_data[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[6]}]

set_property PACKAGE_PIN T27 [get_ports {hdmio_data[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[7]}]

set_property PACKAGE_PIN AD26 [get_ports {hdmio_data[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[8]}]

set_property PACKAGE_PIN AB26 [get_ports {hdmio_data[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[9]}]

set_property PACKAGE_PIN AA28 [get_ports {hdmio_data[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[10]}]

set_property PACKAGE_PIN AC26 [get_ports {hdmio_data[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[11]}]

set_property PACKAGE_PIN AE30 [get_ports {hdmio_data[12]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[12]}]

set_property PACKAGE_PIN Y25 [get_ports {hdmio_data[13]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[13]}]

set_property PACKAGE_PIN AA29 [get_ports {hdmio_data[14]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[14]}]

set_property PACKAGE_PIN AD30 [get_ports {hdmio_data[15]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[15]}]

set_property PACKAGE_PIN Y28 [get_ports {hdmio_data[16]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[16]}]

set_property PACKAGE_PIN AF28 [get_ports {hdmio_data[17]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[17]}]

set_property PACKAGE_PIN V22 [get_ports {hdmio_data[18]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[18]}]

set_property PACKAGE_PIN AA27 [get_ports {hdmio_data[19]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[19]}]

set_property PACKAGE_PIN U22 [get_ports {hdmio_data[20]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[20]}]

set_property PACKAGE_PIN N28 [get_ports {hdmio_data[21]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[21]}]

set_property PACKAGE_PIN V21 [get_ports {hdmio_data[22]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[22]}]

set_property PACKAGE_PIN AC22 [get_ports {hdmio_data[23]}]
set_property IOSTANDARD LVCMOS25 [get_ports {hdmio_data[23]}]


