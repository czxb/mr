def fisher_z(X):
    """
    基于1915年Fisher提出的显式初等函数——Fisher z变换逼近累积正态分布函数
    当x = +-0.731693636946时，绝对误差为0.0442279904503
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import exp
    return 0.5*(1+(exp(2*X)-1)/(exp(2*X)+1))

# fisher_z(1.647)
# fisher_z(-2.3229)

def page(X):
    """
    基于1977年Page提出的初等显式函数逼近累积正态分布函数
    绝对误差小于1.4e-4
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import exp
    (a1, a2) = (0.070565992, 1.5976)
    return (1 - 1/(1+exp(a1*pow(X, 3)+a2*X)))

# page(1.647)
# page(-2.3229)

def hamaker(K):
    """
    基于1978年Hamaker提出的逼近函数近似累积正态分布函数
    当x in [-4, 4]时，绝对误差小于0.005
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import exp
    if (K < -4) | (K > 4) :
        print("请输入一个[-4, 4]范围的数！")
    else:
        X = abs(K)
        cnd = 0.5*(1+pow((1-exp(-(0.806*X*(1-0.018*X))**2)),0.5))
        if K < 0:
            cnd = 1-cnd
        return cnd
# hamaker(1.647)
# hamaker(-2.3229)
# hamaker(5)


def lin(K):
    """
    基于1990年Lin提出的逼近函数近似累积正态分布函数
    当x in (-9, 9)时，绝对误差小于6.8e-3
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    if (K <= -9) | (K >= 9):
        print("请输入一个(-9, 9)范围的数!")
    else:
        X = abs(K)
        from math import exp, pi
        cnd = (1 - 1/(1+exp(4.2*pi*X/(9-X))))
        if K < 0:
            cnd = 1 - cnd
        return cnd
# lin(1.647)
# lin(-2.3229)
# lin(10)

def waissi_rossin(K):
    """
    基于1996年Waissi和Rossin提出的逼近函数近似累积正态分布函数
    当x in (-8, 8)时，绝对误差小于4.31e-5
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    if (K <= -8) | (K >= 8):
        print("请输入一个(-9, 9)范围的数")
    else:
        X = K
        from math import exp, sqrt, pi
        (b1, b2, b3) = (-0.0004406, 0.0418198, 0.9000000)
        return 1/(1+exp(-sqrt(pi)*(b1*pow(X, 5) + b2*pow(X, 3) + b3*X)))

# waissi_rossin(1.647)
# waissi_rossin(-2.3299)

def bryc(K):
    """
    基于2002年Bryc提出的一致逼近函数近似累积正态分布函数
    绝对误差小于1.9e-5
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    X = abs(K)
    from math import exp, pi, sqrt
    cnd = 1.-(X*X + 5.575192*X + 12.77436324) * exp(-X*X/2.)/(sqrt(2.*pi)*pow(X, 3) + 14.38718147*pow(X, 2) + 31.53531977*X + 2*12.77436324)
    if K < 0:
        cnd = 1. - cnd
    return cnd

# bryc(1.647)
# bryc(-2.3229)

def aludaat_alodat(X):
    """
    基于Aludaat和Alodat在2008年提出的逼近函数近似累积正态分布函数
    绝对误差小于0.00197323
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import pi, sqrt, exp
    K = abs(X)
    cnd = 0.5*(1+pow((1-exp(-sqrt(pi/8)*K*K)), 0.5))
    if X < 0:
        cnd = 1 - cnd
    return cnd

# aludaat_alodat(1.647)
# aludaat_alodat(-2.3229)

def yang(X):
    """
    基于杨正瓴在2013年提出的Sigmoid-like形式的逼近函数近似累积正态分布函数
    绝对误差小于0.00945722832868
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import exp
    return 1/(1+exp(-1.70174454109*X))

# yang(1.647)
# yang(-2.3229)

def CND(X):
    """
    计算累积正态分布函数
    :param X: 负无穷到正无穷取值
    :return: 累积正态分布积分值的近似
    """
    from math import sqrt, exp, pi
    (a1, a2, a3, a4, a5) = (0.31938153, -0.356563782, 1.781477937, -1.821255978, 1.330274429)
    L = abs(X)
    K = 1.0/(1.0+0.2316419*L)
    w = 1.0 - 1.0/sqrt(2*pi)*exp(-L*L/2.)*(a1*K+a2*K*K+a3*pow(K,3)+a4*pow(K,4)+a5*pow(K,5))
    if X < 0:
        w = 1.0 - w
    return w
CND(1.647)
CND(-2.3229)

def cnd():
    """
    一系列计算累积正态分布的函数
    基本函数：
        1. fisher_z(X): 基于1915年Fisher提出的显式初等函数——Fisher z变换逼近累积正态分布函数;
        2. page(x): 基于1977年Page提出的初等显式函数逼近累积正态分布函数;
        3. hamaker(K): 基于1978年Hamaker提出的逼近函数近似累积正态分布函数;
        4. lin(K): 基于1990年Lin提出的逼近函数近似累积正态分布函数;
        5. waissi_rossin(K): 基于1996年Waissi和Rossin提出的逼近函数近似累积正态分布函数;
        6. bryc(K): 基于2002年Bryc提出的一致逼近函数近似累积正态分布函数;
        7. aludaat_alodat(X): 基于Aludaat和Alodat在2008年提出的逼近函数近似累积正态分布函数;
        8. yang(X): 基于杨正瓴在2013年提出的Sigmoid-like形式的逼近函数近似累积正态分布函数;
        9. CND(X): 计算累积正态分布函数, Python for Finance书中提供的方法；
    """