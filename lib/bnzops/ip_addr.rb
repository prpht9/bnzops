class IPAddr

  NETMASK_OCTETS = {
    1 => 1..8,
    2 => 9..16,
    3 => 17..24,
    4 => 25..32
  }

  def initialize(str)
    str.match(/(\d+).(\d+).(\d+).(\d+)\/(\d+)/)
    @octet = []
    @octet[0] = $1.to_i
    @octet[1] = $2.to_i
    @octet[2] = $3.to_i
    @octet[3] = $4.to_i
    @netmask = $5.to_i
  end

  def octet1
    return @octet[0]
  end

  def octet2
    return @octet[1]
  end

  def octet3
    return @octet[2]
  end

  def octet4
    return @octet[3]
  end

  def netmask
    return @netmask
  end

  def subnets_by_netmask(netmask)
    raise NetmaskTooBig if netmask <= @netmask
    raise NetmaskNotValid if netmask > 32
    subnets = []
    current_octet = _subnet_octet(@netmask)
    subnet_octet = _subnet_octet(netmask)
    difference = subnet_octet - current_octet
    while difference > 0
      calc_subnets(self)
    end
  end

  def addr
    return "#{@octet[0]}.#{@octet[1]}.#{@octet[2]}.#{@octet[3]}"
  end

  def to_s
    return "#{@octet.join('.')}/#{@netmask}"
  end

  private

  def _subnet_octet(netmask)
    NETMASK_OCTETS.each do |k,v|
      return k if v.include?(netmask)
    end
  end

end

class IPAddr::NetmaskTooBig < StandardError
end

class IPAddr::NetmaskNotValid < StandardError
end

