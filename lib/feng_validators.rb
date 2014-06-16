module FengValidators
  class LettersOnly
    def self.regex
      /\A[a-zA-Z]+\z/
    end

    def self.hint
      "names should be letters only"
    end
  end

  class Username # Username
    def self.regex
      # By Feng Wan
      # 3 -20 letters, numbers, underscore, or hyphens
      /\A[a-z0-9_-]{3,20}\z/
    end

    def self.hint
      "should be 3-20 of a-Z, 0-9 or _"
    end
  end

  class Name # Firstname or Lastname
    def self.regex
      # By Feng Wan
      # 2 - 50 letters only
      # Following Facebook
      /\A[a-zA-Z]{2,50}\z/
    end

    def self.hint
      "should be 2-50 of a-Z"
    end
  end

  class Email # Email
    def self.regex
      # By Feng Wan
      # /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/

      # By Devise
      /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

      # From Web
      # /\A([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})\z/
    end

    def self.hint
      "email format is not correct"
    end
  end

  class Password # Password
    def self.regex
      # By Feng Wan
      # 8 - 30, start with letter, follow with letter, number, underscore
      /\A[a-zA-Z]\w{7,29}\z/

      # From Web
      # /\A[a-z0-9_-]{6,18}\z/
    end

    def self.hint
      "start with letter, 8-30 long"
    end
  end

  class CardNumber < ActiveModel::Validator # Credit Card Number
    def validate(record)
      flag = false
      record.store.payments.each do |p|
        if record.card_number =~ self.send("#{p.name}_regex")
          flag = true
        end
      end
      record.errors[:card_number] << "this store doesn't take this card" unless flag
    end

    def visa_regex
      /\A4[0-9]{12}(?:[0-9]{3})?\z/
    end

    def mastercard_regex
      /\A5[1-5][0-9]{14}\z/
    end

    def american_express_regex
      /\A3[47][0-9]{13}\z/
    end

    def discover_regex
      /\A6(?:011|5[0-9]{2})[0-9]{12}\z/
    end
  end

  class CardVerification # Credit Card Verification
    def self.regex
      /\A[0-9]{3}\z/
    end

    def self.hint
      "should be 3 numbers"
    end
  end

  class CardExpiresOn # Credit Card Expires At
    def self.regex
      /\A(?:0[1-9]|1[0-2])\/[0-9]{2}\z/
    end

    def self.hint
      "should be MM/YY"
    end
  end

  # Distance between User and Store
  # Problem: Errors cannot be shown correctly on the form attributes!
  class Distance < ActiveModel::Validator
    def validate(record)
      dis = record.store.address.distance_to(record.user.address.address)

      if dis.to_s == 'NaN'
        record.errors[:note] << "please enter a valid address"
      elsif dis > record.store.delivery_radius
        record.errors[:note] << "you are too far away from this restaurant"
      end
    end
  end
end


#正则表达式用于字符串处理、表单验证等场合，实用高效。现将一些常用的表达式收集于此，以备不时之需。
#
#匹配中文字符的正则表达式： [\u4e00-\u9fa5]
#评注：匹配中文还真是个头疼的事，有了这个表达式就好办了
#
#匹配双字节字符(包括汉字在内)：[^\x00-\xff]
#评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
#
#匹配空白行的正则表达式：\n\s*\r
#评注：可以用来删除空白行
#
#匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? />
#评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
#
#匹配首尾空白字符的正则表达式：^\s*|\s*$
#评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
#
#匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
#评注：表单验证时很实用
#
#匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
#    评注：网上流传的版本功能很有限，上面这个基本可以满足需求
#
#匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
#评注：表单验证时很实用
#
#匹配国内电话号码：\d{3}-\d{8}|\d{4}-\d{7}
#评注：匹配形式如 0511-4405222 或 021-87888822
#
#匹配腾讯QQ号：[1-9][0-9]{4,}
#评注：腾讯QQ号从10000开始
#
#匹配中国邮政编码：[1-9]\d{5}(?!\d)
#评注：中国邮政编码为6位数字
#
#匹配身份证：\d{15}|\d{18}
#评注：中国的身份证为15位或18位
#
#匹配ip地址：\d+\.\d+\.\d+\.\d+
#评注：提取ip地址时有用
#
#匹配特定数字：
#^[1-9]\d*$　 　 //匹配正整数
#^-[1-9]\d*$ 　 //匹配负整数
#^-?[1-9]\d*$　　 //匹配整数
#^[1-9]\d*|0$　 //匹配非负整数（正整数 + 0）
#^-[1-9]\d*|0$　　 //匹配非正整数（负整数 + 0）
#^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$　　 //匹配正浮点数
#^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$　 //匹配负浮点数
#^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$　 //匹配浮点数
#^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
#^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
#评注：处理大量数据时有用，具体应用时注意修正
#
#匹配特定字符串：
#^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
#^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
#^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
#^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
#^\w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
#评注：最基本也是最常用的一些表达式
