import UIKit
//import Closures


//struct MainCategorySection: Section {
//    var categories : [IdNameImage] = []
//    var numberOfItems: Int = 0
//    init(_ categories : [IdNameImage]){
//        self.categories = categories
//        numberOfItems = min(categories.count, 8)
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .fractionalWidth(0.2))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
//        let section = NSCollectionLayoutSection(group: group)
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {
//            return UICollectionViewCell()
//        }
//        cell.backgroundColor = .white
//        cell.label.text = categories[indexPath.row].name?.capitalized
//        cell.imageView.getAsync("\(category_img_url)\(categories[indexPath.row].image ?? "")")
//        return cell
//    }
//}
//struct SubMainCategorySection: Section {
//    var categories : [IdNameImage] = []
//    var numberOfItems: Int = 0
//    init(_ categories : [IdNameImage]){
//        self.categories = categories
//        numberOfItems = categories.count
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .absolute(80))
////        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        return section
//    }
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {
//            return UICollectionViewCell()
//        }
//        cell.backgroundColor = .white
//        cell.label.text = categories[indexPath.row].name?.capitalized
//        var imgURL : String = ""
//        if (categories[indexPath.row].image ?? "").isValidURL {
//            imgURL = categories[indexPath.row].image ?? ""
//        } else {
//            imgURL = "\(category_img_url)\(categories[indexPath.row].image ?? "")"
//        }
//        if let url = URL(string: imgURL) {
//            cell.imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "default"), options: [.fromMemoryCacheOrRefresh])
//        }else{
//            cell.imageView.image = UIImage.init(named: "default")
//        }
//        return cell
//    }
//}
//struct AdsSection: Section {
//    var numberOfItems: Int = 1
//    var ads : [Offer] = []
//    init(_ ads : [Offer]){
//        self.ads = ads
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
//        return section
//    }
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCell.identifier, for: indexPath) as? AdsCell else {
//            return UICollectionViewCell()
//        }
//        cell.offers = ads
//        return cell
//    }
//}
//struct ShopSection: Section {
//    var stores : [Store] = []
//    var numberOfItems: Int = 0
//    var hasHeader : Bool = false
////    var index : Int?
//    init(_ stores : [Store], hasHeader: Bool){
//        numberOfItems = stores.count
//        self.stores = stores
//        self.hasHeader = hasHeader
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
//        //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//        group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
//        let section = NSCollectionLayoutSection(group: group)
//        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .absolute(50))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionHeader,
//                                                                 alignment: .top)
//        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
//        
//        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .absolute(20))
//        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionFooter,
//                                                                 alignment: .bottom)
//        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
//        if hasHeader {
//        section.boundarySupplementaryItems = [header]
//        }
//        return section
//    }
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell else {
//            return UICollectionViewCell()
//        }
//        cell.name.text = (stores[indexPath.row].name ?? "").capitalized
//        cell.details.text = (stores[indexPath.row].category?.name ?? "").capitalized
//        if stores[indexPath.row].delivery_fees?.doubleValue == 0 {
//            cell.deliveryFees.text = "Free".localized
//            cell.deliveryFees.textColor = UIColor.systemGreen
//        }else {
//            cell.deliveryFees.textColor = UIColor.black
//            cell.deliveryFees.text = "\(stores[indexPath.row].delivery_fees?.rawValue ?? "") \("SAR".localized)"
//        }
//        if stores[indexPath.row].orders_type == "normal" {
//        cell.deliveryTime.text = stores[indexPath.row].delivery_time ?? ""
//            cell.deliveryView.isHidden = false
//        } else {
//            cell.deliveryView.isHidden = true
//        }
//        cell.imageView.getAsync("\(store_img_url)\(stores[indexPath.row].image ?? "")")
//        if self.stores[indexPath.row].is_opened?.doubleValue == 0 {
//            cell.openLabel.isHidden = false
//            cell.openLabel.text = "Closed".localized
//            cell.openLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            cell.openLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            
//        }else {
//            cell.openLabel.isHidden = true
//        }
//        return cell
//    }
//}
//struct ShopSectionHorizontal: Section {
//    var stores : [Store] = []
//    var numberOfItems: Int = 0
//    var index : Int?
//    init(_ stores : [Store]){
//        numberOfItems = stores.count
//        self.stores = stores
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80), heightDimension: .absolute(120))
//        //        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .absolute(50))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionHeader,
//                                                                 alignment: .top)
//        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
//        
//        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                heightDimension: .absolute(20))
//        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
//                                                                 elementKind: UICollectionView.elementKindSectionFooter,
//                                                                 alignment: .bottom)
//        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
//        
//        section.boundarySupplementaryItems = [header]
//        
//        return section
//    }
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell else {
//            return UICollectionViewCell()
//        }
//        cell.name.text = (stores[indexPath.row].name ?? "").capitalized
//        cell.details.text = (stores[indexPath.row].category?.name ?? "").capitalized
//        if stores[indexPath.row].delivery_fees?.doubleValue == 0 {
//            cell.deliveryFees.text = "Free".localized
//            cell.deliveryFees.textColor = UIColor.systemGreen
//        }else {
//            cell.deliveryFees.textColor = UIColor.black
//            cell.deliveryFees.text = "\(stores[indexPath.row].delivery_fees?.rawValue ?? "") \("SAR".localized)"
//        }
//        if stores[indexPath.row].orders_type == "normal" {
//        cell.deliveryTime.text = stores[indexPath.row].delivery_time ?? ""
//            cell.deliveryView.isHidden = false
//        } else {
//            cell.deliveryView.isHidden = true
//        }
//        cell.imageView.getAsync("\(store_img_url)\(stores[indexPath.row].image ?? "")")
//        if self.stores[indexPath.row].is_opened?.doubleValue == 0 {
//            cell.openLabel.isHidden = false
//            cell.openLabel.text = "Closed".localized
//            cell.openLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            cell.openLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            
//        }else {
//            cell.openLabel.isHidden = true
//        }
//        return cell
//    }
//}
//struct ShopsCategorySection: Section {
//    var categories : [IdNameImage] = []
//    var numberOfItems: Int = 0
//    init(_ categories : [IdNameImage]){
//        self.categories = categories
//        numberOfItems = categories.count
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let sideInset : CGFloat = 8
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: sideInset, leading: sideInset, bottom: sideInset, trailing: sideInset)
//        return section
//    }
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {
//            return UICollectionViewCell()
//        }
//        cell.label.text = categories[indexPath.row].name?.capitalized
//        
//        var imgURL : String = ""
//        if (categories[indexPath.row].image ?? "").isValidURL {
//            imgURL = categories[indexPath.row].image ?? ""
//        } else {
//            imgURL = "\(category_img_url)/\(categories[indexPath.row].image ?? "")"
//        }
//        if let url = URL(string: imgURL) {
//            cell.imageView.kf.setImage(with: url)
//        }else{
//            cell.imageView.image = UIImage.init(named: "default")
//        }
//        
//        return cell
//    }
//}
//struct ShopCategorySection: Section {
//    var categories : [ShopCategory] = []
//    var numberOfItems: Int = 0
//    init(_ categories : [ShopCategory]){
//        self.categories = categories
//        numberOfItems = categories.count
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let sideInset: CGFloat = 4
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .estimated(36), heightDimension: .absolute(32)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .estimated(36), heightDimension: .absolute(36)
//        )
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.interGroupSpacing = sideInset
//        section.contentInsets = NSDirectionalEdgeInsets(top: sideInset, leading: sideInset, bottom: sideInset, trailing: sideInset)
//        
//        
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCategoryCell.identifier, for: indexPath) as? ShopCategoryCell else {
//            return UICollectionViewCell()
//        }
//        cell.text = (Language.getCurrentLanguage() == "ar") ? categories[indexPath.row].category_arabic :categories[indexPath.row].category_english?.capitalized
//        return cell
//    }
//}
//struct ShopSubCategorySection: Section {
//    var category : ShopCategory?
//    var subCategories : [String] = []
//    var numberOfItems: Int = 0
//    init(_ category : ShopCategory){
//        self.category = category
//        subCategories = (Language.getCurrentLanguage() == "ar") ? category.subCategory_arabic ?? [] : category.subCategory_english ?? []
//        numberOfItems = subCategories.count
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let sideInset: CGFloat = 4
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .estimated(36), heightDimension: .absolute(32)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .estimated(36), heightDimension: .absolute(36)
//        )
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.interGroupSpacing = sideInset
//        section.contentInsets = NSDirectionalEdgeInsets(top: sideInset, leading: sideInset, bottom: sideInset, trailing: sideInset)
//        
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopSubCategoryCell.identifier, for: indexPath) as? ShopSubCategoryCell else {
//            return UICollectionViewCell()
//        }
//        cell.text = subCategories[indexPath.row]
//        return cell
//    }
//}
//struct ProductSection: Section {
//    var products : [Product] = []
//    var numberOfItems: Int = 0
//    var index : Int?
//    init(_ products : [Product]){
//        self.products = products
//        numberOfItems = products.count
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45),
//                                              heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0), top: nil,
//                                                         trailing: .flexible(16), bottom: nil)
//        let item2 = NSCollectionLayoutItem(layoutSize: itemSize)
//        item2.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil,
//                                                          trailing: .flexible(0), bottom: nil)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .absolute(240))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                       subitems: [item, item2])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
//            return UICollectionViewCell()
//        }
//        return cell
//    }
//}
//struct TitleSection: Section {
//    var numberOfItems: Int = 0
//    private let title: String
//    
//    init(_ title: String) {
//        self.title = title
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell else {
//            return UICollectionViewCell()
//        }
//        cell.label.textAlignment = (Language.getCurrentLanguage() == "ar") ? .right : .left
//        cell.label.textColor = .darkGray
//        cell.label.font = UIFont.myBoldSystemFont(ofSize: 20)
//        cell.label.text = title
//        
//        return cell
//    }
//}
//struct EmptySection: Section {
//    var numberOfItems: Int = 0
//    var bgColor : UIColor?
//    init(_ bgColor : UIColor = UIColor.systemGray6){
//        self.bgColor = bgColor
//    }
//    func layoutSection() -> NSCollectionLayoutSection {
//        let sideInset : CGFloat = 2
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1), heightDimension: .absolute(sideInset)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1), heightDimension: .absolute(sideInset)
//        )
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: sideInset, leading: 0, bottom: sideInset, trailing: 0)
//        return section
//    }
//    
//    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCell.identifier, for: indexPath) as? FooterCell else {
//            return UICollectionViewCell()
//        }
//        cell.backgroundColor = bgColor
//        return cell
//    }
//}
//class EmptyReusableView : UICollectionReusableView {
//    static var identifier: String {
//        return String(describing: self)
//    }
//    var emptyView: UIView = {
//        let v: UIView = UIView()
//        v.backgroundColor = .backgroundColor
//        return v
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(emptyView)
//        emptyView.translatesAutoresizingMaskIntoConstraints = false
//        emptyView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
//        emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 10).isActive = true
//        emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        emptyView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//class SectionHeader: UICollectionReusableView {
//    static var identifier: String {
//        return String(describing: self)
//    }
//    var label: UILabel = {
//        let label: UILabel = UILabel()
//        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        label.font = UIFont(name: "Cairo-Bold", size: 20)
//        label.sizeToFit()
//        return label
//    }()
//    var button: UIButton = {
//        let button: UIButton = UIButton()
//        button.setTitleColor(UIColor.primary, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Cairo-Regular", size: 17)
//        button.imageView?.contentMode = .scaleAspectFit
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(label)
//        addSubview(button)
//        
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: self.topAnchor,constant: 12).isActive = true
//        label.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 4).isActive = true
//        label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12).isActive = true
//        label.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 12).isActive = true
//        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
//        button.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 10).isActive = true
//        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
