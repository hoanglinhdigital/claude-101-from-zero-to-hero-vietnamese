import { PrismaClient, Role, ListingType, PropertyType, ListingStatus } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  const passwordHash = await bcrypt.hash('Passw0rd!', 10);

  const users = [
    { email: 'admin@demo.vn', name: 'System Admin', role: Role.SYSTEM_ADMIN },
    { email: 'mod@demo.vn', name: 'Kiểm duyệt viên', role: Role.MODERATOR },
    { email: 'seller@demo.vn', name: 'Người bán Nam', role: Role.SELLER },
    { email: 'buyer@demo.vn', name: 'Người mua Lan', role: Role.BUYER },
  ];

  for (const u of users) {
    await prisma.user.upsert({
      where: { email: u.email },
      update: {},
      create: { ...u, passwordHash },
    });
  }

  const seller = await prisma.user.findUniqueOrThrow({ where: { email: 'seller@demo.vn' } });
  const buyer = await prisma.user.findUniqueOrThrow({ where: { email: 'buyer@demo.vn' } });
  const mod = await prisma.user.findUniqueOrThrow({ where: { email: 'mod@demo.vn' } });

  if ((await prisma.listing.count()) === 0) {
    await prisma.listing.createMany({
      data: [
        {
          title: 'Căn hộ 2PN view sông Quận 7',
          description: 'Căn hộ 68m2, full nội thất, sổ hồng riêng, gần Phú Mỹ Hưng.',
          type: ListingType.SALE,
          propertyType: PropertyType.APARTMENT,
          priceMillion: 3200,
          areaM2: 68,
          city: 'Hồ Chí Minh',
          district: 'Quận 7',
          status: ListingStatus.APPROVED,
          ownerId: seller.id,
          reviewedById: mod.id,
          reviewedAt: new Date(),
        },
        {
          title: 'Nhà phố 4 tầng hẻm xe hơi Cầu Giấy',
          description: 'Nhà 4 tầng, 52m2, ngõ ô tô tránh, gần trường học.',
          type: ListingType.SALE,
          propertyType: PropertyType.HOUSE,
          priceMillion: 8900,
          areaM2: 52,
          city: 'Hà Nội',
          district: 'Cầu Giấy',
          status: ListingStatus.APPROVED,
          ownerId: seller.id,
          reviewedById: mod.id,
          reviewedAt: new Date(),
        },
        {
          title: 'Cần mua đất nền Đà Nẵng 100m2',
          description: 'Ngân sách khoảng 3 tỷ, ưu tiên gần biển, pháp lý rõ ràng.',
          type: ListingType.WANTED,
          propertyType: PropertyType.LAND,
          priceMillion: 3000,
          areaM2: 100,
          city: 'Đà Nẵng',
          district: 'Sơn Trà',
          status: ListingStatus.PENDING,
          ownerId: buyer.id,
        },
      ],
    });
  }

  console.log('Seed xong: 4 tài khoản (mật khẩu chung: Passw0rd!) và 3 tin mẫu.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
