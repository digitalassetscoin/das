/*
 * Copyright © 2013-2016 The Nxt Core Developers.
 * Copyright © 2016-2017 Jelurida IP B.V.
 *
 * See the LICENSE.txt file at the top-level directory of this distribution
 * for licensing information.
 *
 * Unless otherwise agreed in a custom licensing agreement with Jelurida B.V.,
 * no part of the Nxt software, including this file, may be copied, modified,
 * propagated, or distributed except according to the terms contained in the
 * LICENSE.txt file.
 *
 * Removal or modification of this copyright notice is prohibited.
 *
 */

package das;

import das.db.BasicDb;
import das.db.TransactionalDb;

public final class Db {

    public static final String PREFIX = Constants.isTestnet ? "das.testDb" : "das.db";
    public static final TransactionalDb db = new TransactionalDb(new BasicDb.DbProperties()
            .maxCacheSize(Das.getIntProperty("das.dbCacheKB"))
            .dbUrl(Das.getStringProperty(PREFIX + "Url"))
            .dbType(Das.getStringProperty(PREFIX + "Type"))
            .dbDir(Das.getStringProperty(PREFIX + "Dir"))
            .dbParams(Das.getStringProperty(PREFIX + "Params"))
            .dbUsername(Das.getStringProperty(PREFIX + "Username"))
            .dbPassword(Das.getStringProperty(PREFIX + "Password", null, true))
            .maxConnections(Das.getIntProperty("das.maxDbConnections"))
            .loginTimeout(Das.getIntProperty("das.dbLoginTimeout"))
            .defaultLockTimeout(Das.getIntProperty("das.dbDefaultLockTimeout") * 1000)
            .maxMemoryRows(Das.getIntProperty("das.dbMaxMemoryRows"))
    );

    static void init() {
        db.init(new DasDbVersion());
    }

    static void shutdown() {
        db.shutdown();
    }

    private Db() {} // never

}
