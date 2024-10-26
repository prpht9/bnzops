class BNZOps::Network

  NETMASK_LENGTH = 32
  NETWORK_OCTETS = {
    1 => 0..8,
    2 => 9..16,
    3 => 17..24,
    4 => 25..30
  }

  def initialize(str)
    @octets, @netmask = _parse_cidr(str)
    _validate_input
    @network_octets = _network_octets(@netmask)
    @network_class = _network_class(@netmask)
    @network_length = _network_length(@netmask)
    _set_default_subnet_netmask
  end

  def subnet_count()
    network_length / subnet_length
  end

  def subnets(count = subnet_count)
    subnets = []
    subnets << BNZOps::Network.new("#{addr}/#{@subnet_netmask}")
    (count - 1).times do
      s = subnets.last
      ocs, nm = _parse_cidr("#{s.broadcast}/#{s.netmask}")
      if ocs[3] != 255
        ocs[3] += 1
      elsif ocs[2] != 255
        ocs[2]+= 1
        ocs[3] = 0
      elsif ocs[1] != 255
        ocs[1]+= 1
        ocs[2] = 0
        ocs[3] = 0
      else
        raise SubnetsLogicError
      end
      subnets << BNZOps::Network.new("#{ocs.join('.')}/#{nm}")
    end
    result = []
    subnets.each do |s|
      result << s.to_s
    end
    return result
  end

  def subnet_netmask=(netmask)
    @subnet_netmask = netmask
  end

  def subnet_netmask()
    return @subnet_netmask
  end

  def subnet_class()
    return _network_class(subnet_netmask)
  end

  def subnet_length()
    return _network_length(@subnet_netmask)
  end

  def octets
    return @octets
  end

  def octet1
    return @octets[0]
  end

  def octet2
    return @octets[1]
  end

  def octet3
    return @octets[2]
  end

  def octet4
    return @octets[3]
  end

  def netmask
    return @netmask
  end

  def addr
    return @octets.join('.')
  end

  def cidr
    return "#{@octets.join('.')}/#{@netmask}"
  end

  def tld
    return cidr
  end

  def to_s
    return cidr
  end

  def to_a
    return @octets
  end

  def first_ip
    return "#{@octets[0]}.#{@octets[1]}.#{@octets[2]}.#{@octets[3] + 1}"
  end

  def broadcast()
    case @network_class
    when 'a'
      return [octet1 + (network_length / 256 / 256 / 256) - 1, 255, 255, 255].join('.')
    when 'b'
      return [octet1, octet2 + (network_length / 256 / 256) - 1, 255, 255].join('.')
    when 'c'
      return [octet1, octet2, octet3 + (network_length / 256) - 1, 255].join('.')
    when 'd'
      return [octet1, octet2, octet3, octet4 + (network_length) - 1].join('.')
    else
      raise BroadcastLogicError
    end
  end

  def last_ip
    ocs, nm = _parse_cidr("#{broadcast}/#{@netmask}")
    return [ocs[0], ocs[1], ocs[2], ocs[3] - 1].join('.')
  end

  def netmask
    return @netmask
  end

  def network_class
    return @network_class
  end

  def network_octets
    return @network_octets
  end

  def network_length
    return @network_length
  end

  private

  def _validate_input
    raise NetmaskInvalid unless @netmask.between?(0, 32)
    @octets.each do |octet|
      raise OctetInvalid unless octet.between?(0, 255)
    end
  end

  def _network_octets(netmask)
    NETWORK_OCTETS.each do |k,v|
      return k if v.include?(netmask)
    end
  end

  def _network_class(netmask)
    i = _network_octets(netmask)
    case i
    when 1
      return "a"
    when 2
      return "b"
    when 3
      return "c"
    when 4
      return "d"
    end
  end

  def _network_length(netmask)
    x = NETMASK_LENGTH - (netmask - 1)
    count = 0
    b = []
    until count == x -1
      count += 1
      b.unshift('0')
    end
    b.unshift('0b1')
    return eval(b.join)
  end

  def _set_default_subnet_netmask
    case @network_length
    when 4..256
      @subnet_netmask = nil
    when 512..65536
      @subnet_netmask = 24
    when 65537..16777216
      @subnet_netmask = 16
    else
      @subnet_netmask = 12
    end
  end

  def _parse_cidr(str)
    ocs = []
    str.match(/(\d+).(\d+).(\d+).(\d+)\/(\d+)/)
    ocs << $1.to_i
    ocs << $2.to_i
    ocs << $3.to_i
    ocs << $4.to_i
    nm = $5.to_i
    return [ocs,nm]
  end

end

class BNZOps::Network::NetmaskInvalid < StandardError
end

class BNZOps::Network::OctetInvalid < StandardError
end

class BNZOps::Network::SubnetsLogicError < StandardError
end

class BNZOps::Network::BroadcastLogicError < StandardError
end
