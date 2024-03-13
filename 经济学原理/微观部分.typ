#import "../template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: note.with(
  title: "经济学原理（微观部分）",
  author: "YHTQ",
  date: none,
  logo: none,
)
= 前言
        本门课程上下分两个学期，主要是经济学入门课程，介绍经济学的基本原理，微观经济学基础。
        教师：田巍\
        讨论班：25，26为通选课\
        考核：平时20%，期中（11月13日）30%，期末（1月8日）50%
        （不会有概念默写类的题目）\
        注意作业题和 PPT 上题目\
        参考书：（无教材，作业考试以上课要求为准，仅参考）
        - 平狄克、鲁宾费尔德：《微观经济学》，中国人民大学出版社
        - 范里安：《微观经济学：现代观点》，格致出版社
        - 平新乔：《微观经济学十八讲》，北京大学出版社
    == （微观）经济学的研究内容
        - 经济学研究在资源稀缺的情况下，个体（消费者、厂商、资本等要素）如何做出选择，以实现尽可能大的经济收益。
        - 稀缺性指社会资源是有限的，是经济学研究的前提假设。
        - 个体行为（或如何配置资源）是经济学研究的核心，经济效率是经济学研究的目标。
        本学期基本内容：
        - 供给和需求的基本原理
        - 消费者理论：消费者行为，个人需求与市场需求
        - 生产者理论或厂商理论：企业或生产者如何做出决策
        - 市场理论：
            - 产品市场：交换行为
            - 要素市场：购买生产要素行为
        经济学理论难以完美刻画社会运行规律，仅能提供方向参考
    == 生产要素
        生产要素：
            - 自然资源
            - 资本（$K$）
                - 有形资本（机器厂房，股票债券）
                - 无形资本（专利，商标，知识产权）
            - 劳动力（$L$）：劳动力不等价于人，而是指抽象的人的劳动能力
        生产要素是是流量概念而非存量概念，购买生产要素也是单位时间内的行为。

        生产要素的稀缺性决定了产品也是稀缺的，因此生产要素和产品都需要支付价格购买。

    == 微观经济学是经济学的基础
        - 对企业而言，决策的目的是 _最大化利润_
        - 对消费者而言，决策的目的是 _最大化效用_

        政府会对生产交易的每个环节进行约束干扰，从而影响个体的行为，比如征税

        经济学还有其他分支，例如宏观经济学，金融学，企业理论，产业组织，国际经济学
    == 个体决策的关键词
        - 权衡取舍 trade-offs
        - 机会成本 opportunity cost：资源是有限的，如果一定量资源用于决策A的收益低于决策B，则将会做出B的决策（本课程中，机会成本被定义为成本 + 放弃的最大收益）
        - 理性自利 rationality：按照对自己最有利的方式决策，$eq.not$ 自私
        - 激励 incentives
    == 市场、交易和价格
        个体之间的交易改进社会总体福利，因此交易行为会发生。换言之，专业化生产提高了效率，但是需要交易才能实现。当然专业化未必是最优的，在有些场景下确实需要自给自足。
        - 市场：产品的买卖双方的集合，包括买方、卖方和产品
            - 范围：市场的范围包括地理范围，产品范围等等。地理范围多数时候无明确界限，产品之间也不可能一摸一样，因此现实中许多市场难以界定范围。在这门课中我们往往不会讨论市场的范围，而是直接给定市场。
            - 结构：不同的产品，买卖方产生了不同的市场结构。经济学理论中常常讨论的有完全竞争市场，垄断市场，垄断竞争市场，寡头垄断市场等等。其核心差别在于价格形成机制的不同。
        - 价格：市场中最核心的要素（看不见的手），是市场经济中调配资源配置的手段，直接影响成本和收益从而影响个体决策，由买卖双方通过一定过程形成（_在市场经济中，价格在任何情况下都是由市场决定的_）。事实上，在非常理想的情况下，价格可以看作参与市场的个体需要的唯一信息。
            \ 注：事实上当今所谓的市场经济国家几乎不可能是完美的市场经济，当代市场经济国家的政府往往都会对市场进行强力调控。当然，经济学理论中往往假设市场经济是完美的。
            - 免费的物品没有稀缺性，但没有稀缺性的物品不能称为商品。换言之，商品的价格不可能为零。
            - 价格总是在不断变化的。CPI（居民消费价格指数）是衡量价格变化的指标。
        - 当买方购买量和卖方的生产量达到平衡时，称为市场达到均衡。此时价格一定，个体的决策也一定。
        - 如果所有考虑的市场都达到均衡，称为一般均衡（general equilibrium）。显然这是一种理想状态。
        - 帕累托效率：指资源分配的一种理想状态，即在一定市场均衡下，不存在其他资源分配方法使得任何人境况都不变差的情况下，有人境况变好。
        - 帕累托有效：指资源分配所能达到的最优资源配置。最优效率并不意味着最公平。
        - 当市场均衡不能达到帕累托有效时，称为市场失灵。市场失灵的原因有很多，例如外部性，公共物品，不完全竞争等等。
= 供给和需求
        当进行供需分析时，我们假设市场是完全竞争的或者至少竞争程度很高：
        + 产品完全同质化
        + 潜在无穷多的竞争者（单个个体的供给和需求对市场微乎其微，市场进出无成本）
        + 买卖双方都是价格接受者（价格接受者：价格不受单个个体影响）
        消费者和生产者分别产生需求和供给曲线，换言之供给和需求完全由价格决定。供给和需求的交点即为市场均衡点。此时看不见的手完全决定资源分配。\
        在一般而言，我们讨论供给/需求曲线当且仅当厂商/消费者是价格的接受者
    == 需求
        消费者在一定时期内，在一定价格水平下愿意而且能够购买的商品或服务的数量，是购买意愿和支付能力的统一。
        - 需求定律：需求和价格负相关，其函数关系构成需求曲线。为了研究方便，在交易量极大时可以看作连续曲线
        影响需求的因素：
        + 价格
        + 消费者收入
            - 正常商品：收入增加需求增加
            - 低档商品：收入增加需求减少
        + 相关商品价格
            - 替代品：替代品价格增加导致价格增加
            - 互补品：互补品价格增加导致价格减少
        + 消费者偏好
        + 消费者对未来的期望
        + 人口数量/结构
        + ......
        所谓需求曲线是以上所有因素不变时，价格和需求的关系。显然需求曲线的参数是其他影响因素的函数。
        - 保留价格：愿意为某商品支付的最高价格（降低购买数量的阈值），显然它就是需求曲线上的对应点
        - 消费者剩余：每单位商品的保留价格和实际价格之间的差值综合总和，往往用于近似替代消费者福利
    == 供给
        供给是指在一定时期内，一定价格水平下，生产者愿意而且能够提供的商品或服务的数量，是生产者的供给意愿和供给能力的统一。
        - 供给定律：供给和价格正相关
        影响供给的因素：
        + 价格
        + 生产成本
            - 生产要素价格
            - 生产技术
        + 生产者技术水平
        + 生产者对未来的期望
        + 相关产品价格
        + 政府的产业政策
        + ......
    == 均衡
        - 供给等于需求的状态称为平衡
        - 供给过量/不足称为过剩、短缺
        - 均衡状态会被其他因素的改变而打破，一段时间后达到新的平衡2
    == 限价
    如果政府认为均衡价格过高，就可能规定低于均衡价格的最高限价，但此时由于供需关系，供给减少，需求增加，自然会出现资源短缺。若要达到福利的目的，必须对生产者进行补贴。\
    类似的，有些商品会规定最低限价以保护生产者，比如典型的粮食往往会同时有最低和最高限价。单纯的最低限价会导致生产过剩，往往会结合政府收购等模式。\
    从以上例子可以看出，对于正常运转的市场进行政府干预往往要付出很大的成本。
    == 贸易条件
    称一个国家出口某商品的世界价格 / 进口某商品的世界价格\
    对于经济体量极大的大国，大量进口，出口商品都会导致贸易条件恶化，从而导致福利下降。\
    这可能可以解释一些发展中国家 “贫困化增长”，越进行贸易越发贫困。

= 需求和供给弹性
    弹性表示了价格影响供给/需求的程度。\
    由于供需曲线横纵轴的选取，越平坦的曲线表示商品供需受价格影响越剧烈。\
    定义：
    $
    (delta x(p)) / (delta p) \/ (x(p) / p)
    $
    为商品 $x$ 关于价格 $p$ 的（点）弹性。
    有时也有弧弹性，用一段弧的割线替代$(delta x(p)) / (delta p)$，用中点替代 $(x(p) / p$
    == 需求的价格弹性
        简称需求弹性\
        一般而言，需求随价格增加而减少，因此 $epsilon <0$\
        有时也会不带符号直接考虑绝对值\
        - 若 $|epsilon| = 1$，称需求是单位弹性
        $
        (delta x(p)) / (delta p) = -x(p) / p \
        ln (x(p)) = ln (1/p) + c\
        x(p) = A / p
        $
        - 若 $|epsilon| > 1$，称需求是有弹性（也称商品是奢侈品）
        - 若 $|epsilon| < 1$，称需求是缺乏弹性（也称商品是必需品）
        往往花费占收入更大的商品弹性更大，难以替代的需求弹性更小，变化速度越快的价格弹性越小。\
        注意到商家微调价格的收入（这里没有考虑利润）约为：
        $
        (P + d P)(Q + d Q) = P Q + P d Q + Q d P + d P d Q = P Q + P d Q + Q d P \
        = P Q + (P d Q + Q d P) = P Q + Q d P (1 + epsilon)
        $
        从而：
        - 若 $|epsilon| > 1$，降低价格收入增加
        - 若 $|epsilon| < 1$，降低价格收入降低
    
    == 需求的交叉价格弹性
        称：
        $
        (delta q_1 / delta p_2) / (q_1 / p_2)
        $
        为商品 $1$ 对商品 $2$ 的价格的交叉价格弹性。\
        显然替代品的交叉价格弹性为正，互补品的交叉价格弹性为负。\
= 消费者偏好
    == 商品束
        消费束或者商品束是一种或多种商品的组合，一个长度为商品数量，分量为商品数量的向量。\
        消费者在不同的商品束之间的选择称为消费者的偏好。
    == 消费者偏好的假设
        + 完备性：消费者能够对任意两个商品束进行比较得出偏好
        + 传递性：若 $A$ 比 $B$ 好，$B$ 比 $C$ 好，则 $A$ 比 $C$ 好
        + 反身性：$A$ 和 $A$ 一样好
        以下是一些额外假设，满足的称为良性偏好
        + 非饱和性
        + 单调性
        + 凸性
    == 边际替代率
        衡量消费者为了获得额外一单位商品愿意放弃的另一种商品的数量。\
        $
        "MRS" = - (delta x_1) / (delta x_2)
        $
        无差异曲线都是直线或者边际替代率都是常数时称为完全替代。
        无差异曲线出现直角，边际替代率只取0或无穷时称为完全互补。
    == 偏好函数
        用偏好函数是一种将商品束映射到实数的函数。\
        称只关心排序的效用函数为序数效用，同时需要考虑数的大小的为基数效用。\
    == 预算限
        消费者可用于消费的收入是有限的。恰好花完收入的商品束构成一个集合，称为预算限。\
        对于理性的消费者，应当在预算限上最大化效益。几何上看，就是无差异曲线与预算曲线相切状态。

    == 案例：税收机制讨论
        + 从量税/从价税：按照购买商品的数量/价格的一定比例收取税款
        + 所得税：按照收入的一定比例收取税款
    == 替代效应与收入效应
        在个人需求曲线上，每一点都是消费者效用最大化的结果。因而随着价格下降，由于消费者选择多买，效益一定是提高的。\

        在消费者理论的基础上，可以将需求的变换分为两种：
        - 替代效应：相对价格变动，效用不变引发的需求变化称为替代效应
        - 收入效应：价格降低导致实际购买力的变动引发效用上升称为收入效应

        衡量购买力不变有不同方法。以效用水平不变表示购买力不变称为 Hicks 分解，以依旧购买原商品称为 Slustsky 分解。

        对于低档品，价格下降会引起正的替代效应和负的收入效应。一般而言大部分低档品都有替代效应强于收入效应，收入效应更强，也即价格下降会导致最终需求下降到商品称为吉芬品。

        现实中，吉芬品是否存在仍是争议问题。

        当效用函数形如：
            $
                u = X + f(Y)
            $
        也即对商品 $X$ 线性时，效用最大化条件为：
            $
            p_1 / p_2 = 1/f'(Y)
            $
        此时意味着 $Y$ 与收入是无关的，只与相对价格有关。换言之收入改变对 $Y$ 的消费量没有影响
= 生产者理论 
    企业追求利润最大化，面临的主要决策因素为：
        + 生产技术：描述投入品如何转化为产出
        + 成本约束：投入品价格与数量的约束
        + 生产则选择：在一定的生产技术和投入品价格下，企业如何选择每种投入品以及产出的数量，使得利润最大化。
    == 短期生产函数
        短期而言，一般来说只有劳动投入是容易改变的。假设在短期、资本固定不变，而劳动投入可变，厂商如何选择劳动投入以提高产量，这被称为短期生产函数。

        在资本不变的前提下，典型的随着劳动力投入数量的变化时，总产出、边际产出、平均产出都应该是先增加后下降，归根到底是劳动力数量与资本数量的匹配

        边际产出递减：在生产技术不变的前提下，随着投入要素的增加，最终的边际产出一定会下降（这并不是因为劳动力素质的变化而是劳动力与资源的配比）
    == 等产量线
        长期而言，产出将是各项投入的函数。往往考虑 K 为资本，L 为劳动力。实现相同产出的不同生产要素投入的配比称为等产量线。

        由于一般而言平衡优于极端，因此我们一般假定生产函数是单调的，凸的，也就是平均生产要素的产出大于产出的平均。

        注意：显然产值的值是有意义的，因此生产函数是基数函数。

        等产量线的导数称为边际技术替代率：
        $
        "MRTS"_(L K) = (delta K)/(delta L)
        $

        生产函数中也可以有完全替代和完全互补两种极端情形。

        规模报酬：扩张规模带来的报酬，也即：
            $
            log_k (F(k overline(x))/F(overline(x)))
            $
            它表示扩张资本、劳动力的效果，大于一时称规模报酬递增，小于一时称规模报酬递减，等于一时称为规模效应不变

            规模报酬递增的原因：
                + 生产要素的专用性
                    一台机器的一百倍不一定意味着一百台机器，而可能是一百倍价值的流水线，每个劳动力可以专业化分工
                + 生产经营的不可分性
                    不能买半条流水线
            规模报酬递减的原因：
                + 管理成本膨胀
            
            规模报酬随规模变化往往也会呈现先上升后下降的趋势。如果把管理资源也看成一种生产要素，管理部门的扩张往往远远慢于正常部门的扩张，因此也可以看成边际报酬递减的特例。
    == 成本函数
        生产成本往往会分成多部分
        + 会计成本
            账面上花出的钱
        + 机会成本
            机会成本是指企业为了生产而放弃的最高收益，也即机会成本 = 账面成本 + 放弃的最高收益
        + 沉没成本
            已经花出的成本。注意沉没成本已经沉没了，决策时不应该考虑已经花出的成本。
        + 固定成本
            （在模型内）无法改变的成本，与沉没成本的差距在于可以（部分）收回
        + 可变成本
            （在模型内）可以改变的成本
        边际成本：单位产出的成本，仅对可变成本有效，对固定成本无效。\
        边际成本往往先下降后上升，它和边际产出先上升后下降是相对应的，也有类似的原因：
            - 投入较低时，增加投入增加专业化，边际成本下降
            - 投入较高时，再增加投入时管理成本膨胀，边际成本上升。
    == 利润最大化/成本最小化
        一般而言，我们假设企业是要素市场价格的接收者，也即企业的决策不改变要素市场价格。\
        追求利润最大化和成本最小化是等效的，可以理解为在等成本线上找到最大产量或者在等产量线上找到最小成本。\
        因此，厂商利润最大化的根本条件是边际收益等于边际成本。\
    == 规模经济
        它是规模报酬的一种推广，用当产出增加一定倍数时，成本的增加倍数来衡量。\
        当成本增加倍数小于产出增加倍数时，称为规模经济，反之称为规模不经济。\
        规模经济经常用成本产出弹性：
        $
        (partialDer(c, q))/(c/q)
        $
        （ c 表示成本，q 表示产出）
        衡量。小于一时称为规模经济，大于一时称为规模不经济。
    == 完全竞争市场的生产者理论
        复习三个假定：
        - 产品完全同质化
        - 潜在无穷多的竞争者，进出没有成本
        - 买卖双方都是价格接受者
        生产者是价格的接受者，因此才会有供给-价格曲线的存在

        短期和长期的区别：
            - 长期所有生产要素可以改变，短期只有少数生产要素可以改变
            - 长期完全竞争市场中，所有厂商可以自由进出，短期则无法进出
        
        长期而言，企业有退出的选项，因此若无论如何都会亏损，则企业当然会退出\
        而短期而言，需要考虑固定成本的问题。企业此时无法退出，不生产时也需要支付固定成本。因此若平均可变成本曲线低于价格，企业虽然生产也会亏损，但不生产亏损更大，因此会选择生产；反之会选择停产。\
        完全竞争市场的长期状态：
        - 每个生产者都是利益最大化 $=> P = "边际成本"$
        - 利润为零（否则厂商会进入/退出）$=> P = "平均成本"$
        - 市场出清（供给等于需求）

        这表明完全竞争市场中，所有生产者应当都处边际成本曲线与平均成本曲线的交点，也即平均成本曲线的最低点。\

        同时，这表明如果平均成本一直下降，则这样的厂商不能存在。\

        完全竞争市场实现了所有可能的交换，因此某种意义上是最大的福利。\

        既然在长期竞争市场中，所有生产者利润都为零，那么为什么还有人愿意进入市场呢？\
        - 短期内企业得到利润，这个短期在现实生活中可能很长
        - 我们所谈的都是机会成本，而会计成本小于机会成本，因此最终还是能够盈利。
        - 若某个企业拥有某项技术能够降低成本，那么它就能够获得利润。但是从机会成本的角度来说，技术带来的收益就是它隐含的（转卖给别人）的机会成本，因此总利润仍然为零。

        短期供给曲线就是每个厂商的供给曲线加总，长期则并不然，它取决于生产要素受产业扩张的影响程度。例如：
        - 若行业扩张对要素价格不产生影响
        - 若行业扩张导致要素价格降低，则更多企业进入，价格更低
    == 垄断市场
        假设某个市场中，进入成本很大导致只有一个生产者，而消费者仍然潜在无穷多。此时定价权实际由唯一的生产者决定，此种市场称为完全竞争市场。\
        在完全竞争市场中，厂商的定价策略当然应该让总利润，也即：
        $
        P Q -  "Cost" (Q) " ,where" Q = "Demand"(P) 
        $
        其中 $"Demand" (Q)$ 就是市场的需求函数
        最大化
    == 价格歧视
        在垄断市场下，商家可以采用称作价格歧视的策略，不将价格制定为统一价格，而将商品卖给更愿意付出高价的买家。
        + 一级价格歧视：同时依据买家和数量制定价格，完全状态是每一个商品都恰好以最高的保留价格卖出，消费者剩余为零，社会总福利全部由生产者占有。
        + 二级价格歧视：只根据数量，例如最典型的套餐销售、两步定价（先交固定价格，再交可变价格），实践上成本较小，因此更为常见。
        + 三级价格歧视：只根据人群定价，要求人群身份不能随便冒充，例如不同地区的连锁店定价不同
    == 垄断竞争市场
        介于垄断市场与竞争市场之间，假设为：
        - 产品间有差异性和一定程度的可替代性
        - 自由进入和退出，长期而言利润为零
        厂商的定价策略当然应该让总利润，也即：
        $
        P Q -  "Cost"(Q) " ,where" Q = "Demand"(P)\
        $
        最大化。\
        与垄断市场不同，此时 $"Demand"(P)$ 是厂商所面临的需求函数，它的弹性比整个市场面临的需求函数量值更小，弹性更大。\
        短期而言，厂商可以通过这样的定价策略获得利润。长期而言，由于自由进入，单个厂商面临的需求函数会萎缩，导致利润降低，最终降为零。\
        换言之，长期而言边际收益曲线，边际成本曲线交点的 $Q$ 恰好就是平均成本曲线与需求曲线交点的 $Q$ 。同时，由于利润不能为正，因此平均成本不能低于需求曲线，最终导致平均成本曲线应该与需求曲线相切。（此时平均成本事实上是下降的）\
    == 寡头垄断市场
        比垄断竞争市场垄断性更强，较垄断市场多了不同企业间的策略性行文。假设为：
        - 市场有很强的进入壁垒
        - 厂商数量较少，拥有大部分或者全部的产量
        - 产品之间可能有差异性可能没有
        在寡头垄断市场中，不能只简单地最优化自己的利润，因为一方的决策可能对其他寡头造成影响，导致市场条件发生变化，这在之前的市场结构是没有出现过的。因此，某种意义上寡头垄断市场是一大类市场结构而不是一种市场结构。\
        在具体的决策中，若干寡头之间的决策可能会产生博弈论问题。在多方博弈中，如果每个人都已经实现了当前它人决策下的最优决策，则称为一个纳什均衡。\
        注意纳什均衡可能有多个，也可能没有。同时，纳什均衡即使存在也未必能实现。\
        古诺模型：简单的双寡头模型，两个垄断寡头在同一个市场售卖完全相同的商品，并且知道市场需求信息。一方扩张产量会压低市场价格从而影响他方的利润。\
            在这个模型下，一方的所有决策就是产量。他方可以通过假设对方的产量决定自己的产量（这个曲线称为反应曲线），最终求解出纳什均衡状态。